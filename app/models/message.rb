class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates :body, presence: true, length: { maximum: 2200 }
  validates :conversation_id, presence: true
  validates :user_id, presence: true
end
