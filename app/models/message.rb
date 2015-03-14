module Messages
  class HeadlinesFinder
    def initialize(user)
      @user = user
      @messages = []
      @other_user_ids = []
    end

    def call
      messages = Message.order(created_at: :desc).related_to(@user)

      messages.each do |message|
        other_user_id = (message.from_user_id == @user.id) ? message.to_user_id : message.from_user_id

        unless other_user_id.in?(@other_user_ids)
          @messages << message
          @other_user_ids << other_user_id
        end
      end

      @messages
    end
  end
end

class Message < ActiveRecord::Base
  belongs_to :from_user, class_name: 'User', foreign_key: 'from_user_id'
  belongs_to :to_user, class_name: 'User', foreign_key: 'to_user_id'

  validates :content, presence: true
  validates :from_user, presence: true
  validates :to_user, presence: true

  scope :related_to, ->(user) { where('from_user_id = :user_id OR to_user_id = :user_id', user_id: user.id) }

  scope :headlines_for, ->(user) do
    messages = self.find_by_sql([HEADLINES_SQL, {user_id: user.id}])
    ids = messages.map(&:id)
    where(id: ids).order(id: :desc)
  end

  HEADLINES_SQL = <<-SQL
SELECT MAX(m2.id) AS id
FROM   (SELECT m.from_user_id AS other_user_id,
               m.id
        FROM   messages m
        WHERE  m.to_user_id = :user_id
        UNION ALL
        SELECT m.to_user_id AS other_user_id,
               m.id
        FROM   messages m
        WHERE  m.from_user_id = :user_id) m2
GROUP  BY m2.other_user_id
  SQL
end
