class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :posts, dependent: :destroy
  has_many :video_posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :follows

  has_many :follower_relationships, foreign_key: "following_id", class_name: "Follow"
  has_many :followers, through: :follower_relationships, source: :follower, dependent: :destroy

  has_many :following_relationships, foreign_key: "user_id", class_name: "Follow"
  has_many :following, through: :following_relationships, source: :following, dependent: :destroy

  has_many :saved_posts, dependent: :destroy

  has_many :sender_conversations, foreign_key: "sender_id", class_name: "Conversation", dependent: :destroy

  has_many :receiver_conversations, foreign_key: "recipient_id", class_name: "Conversation", dependent: :destroy
  
  has_many :messages, dependent: :destroy
  
  VALID_USERNAME_REGEX = /\A[a-zA-Z0-9]+\z/
  validates :username, uniqueness: true, case_sensitive: false, presence: true, length: {minimum: 4, maximum: 16}, format: { with: VALID_USERNAME_REGEX }

  validates :first_name, :last_name, presence: true, length: { minimum: 1, maximum: 60 }

  validates :bio, length: { maximum: 150 }

  has_one_attached :avatar, dependent: :destroy
  validate :avatar_type

  private

  def avatar_type
    if avatar.attached?
      if !avatar.content_type.in?(%('image/jpeg image/jpg image/png'))
        errors.add(:avatar, "needs to be JPG or PNG")
      end
    else
      'default_profile.jpg'
    end
  end
end
