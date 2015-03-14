class Message < ActiveRecord::Base
  belongs_to :from_user, class_name: 'User', foreign_key: 'from_user_id'
  belongs_to :to_user, class_name: 'User', foreign_key: 'to_user_id'

  validates :content, presence: true
  validates :from_user, presence: true
  validates :to_user, presence: true
end