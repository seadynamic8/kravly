# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)
#  email           :string(255)
#  firstname       :string(255)
#  lastname        :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  password_digest :string(255)
#

class User < ActiveRecord::Base
	has_secure_password

	has_many :boards, dependent: :destroy

	EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :username, uniqueness: true, length: { maximum: 255 }
	validates :email, presence: true, uniqueness: true, format: EMAIL_REGEX
	validates :firstname, length: { maximum: 255 }
	validates :lastname, length: { maximum: 255 }
	validates :password, presence: true, on: :create
	validates :password, length: { in: 8..30 }, on: :create

	def fullname
		name = "#{firstname} #{lastname}"
		if name.blank?
			name = "#{username}"
		end
		if name.blank?
			name = "#{email}"
		end

		return name
	end

end
