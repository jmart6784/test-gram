class VideoPost < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :saved_posts, dependent: :destroy

  validates :caption, length: { maximum: 2200 }

  has_one_attached :clip, dependent: :destroy

  validate :clip_presence
  validate :clip_type, unless: ->(x) { x.clip.blank? }
  
  private

  def clip_presence
    unless clip.attached?
      self.errors[:base] << "Video must be attached"
    end
  end

  def clip_type
    if clip.attached? && !clip.content_type.in?(%(video/mp4))
      errors.add(:clip, "must be an MP4")
    end
  end
end
