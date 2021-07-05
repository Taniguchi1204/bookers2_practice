class Book < ApplicationRecord
	belongs_to :user
	has_many :favorites, dependent: :destroy
	has_many :book_comments, dependent: :destroy


	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}

	def favorite_include?(user)
		favorites.where(user_id: user.id).exists?
	end

	def self.search_for(content, method)
		if method == "perfect"
			User.where(name: content)
		elsif method == "forward"
			User.where("name like ?", "#{content}%")
		elsif method == "backward"
			User.where("name like ?", "%#{content}")
		else
			User.where("name like ?", "%#{content}%")
		end
	end
end
