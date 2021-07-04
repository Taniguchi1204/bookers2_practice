class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  attachment :profile_image, destroy: false

  has_many :followed_users, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :followed_users, source: :following

  has_many :follower_users, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
  has_many :followings, through: :follower_users, source: :followed

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}

  def follow(user_id)
    follower_users.create(followed_id: user_id)
  end

  def unfollow(user_id)
    follower_users.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end
end
