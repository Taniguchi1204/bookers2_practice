class Book < ApplicationRecord
	belongs_to :user
	has_many :favorites, dependent: :destroy
	has_many :favorited_user, through: :favorites, source: :user
	has_many :book_comments, dependent: :destroy
	has_many :view_counts, dependent: :destroy


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

	scope :created_today, -> { where(created_at: Time.zone.now.all_day) }
	scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) }
	scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) }
	scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) }
	scope :created_2day_ago, -> { where(created_at: 2.day.ago.all_day) }
	scope :created_3day_ago, -> { where(created_at: 3.day.ago.all_day) }
	scope :created_4day_ago, -> { where(created_at: 4.day.ago.all_day) }
	scope :created_5day_ago, -> { where(created_at: 5.day.ago.all_day) }
	scope :created_6day_ago, -> { where(created_at: 6.day.ago.all_day) }
end
