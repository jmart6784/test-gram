class Comment < ApplicationRecord
  belongs_to :post, optional: true
  belongs_to :video_post, optional: true
  has_many :likes, as: :likeable, dependent: :destroy

  validates :body, presence: true
  validates :body, length: { maximum: 2200 }
end
