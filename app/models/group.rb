class Group < ApplicationRecord
  has_many :group_users
  has_many :users, through: :group_user, source: :user
  attachment :image

  def group_users_include?(user)
    group_users.where(user_id: user.id).exists?
  end
end
