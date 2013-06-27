class User < ActiveRecord::Base

	EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :username, presence: true, uniqueness: true, length: { maximum: 255 }
	validates :email, presence: true, uniqueness: true, format: EMAIL_REGEX
	validates :firstname, presence: true, length: { maximum: 255 }
	validates :lastname, presence: true, length: { maximum: 255 }

	

	def fullname
		return "#{firstname} #{lastname}"
	end

end
