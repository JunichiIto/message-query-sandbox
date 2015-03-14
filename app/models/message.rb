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

  def self.headlines_for(user)
    Messages::HeadlinesFinder.new(user).call
  end
end
