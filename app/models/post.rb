class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :saved_posts, dependent: :destroy

  validates :caption, length: { maximum: 2200 }

  has_one_attached :image, dependent: :destroy
  validates :image, presence: true

  validate :image_type, unless: ->(x) { x.image.blank? }
  
  private

  def image_type
    if image.attached? && !image.content_type.in?(%(image/jpeg image/png))
      errors.add(:image, "must be a JPEG or PNG.")
    end
  end
end
