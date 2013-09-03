# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  username               :string(255)
#  email                  :string(255)
#  firstname              :string(255)
#  lastname               :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  password_digest        :string(255)
#  password_reset_token   :string(255)
#  password_reset_sent_at :datetime
#  image                  :string(255)
#  avatar                 :string(255)
#

require 'file_size_validator'

class User < ActiveRecord::Base
	has_secure_password

	has_many :boards, dependent: :destroy

	mount_uploader :avatar, AvatarUploader

	normalize_attributes :username, :email, :firstname, :lastname, :avatar

	EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :username, uniqueness: true, length: { maximum: 255 }
	validates :email, presence: true, uniqueness: true, format: EMAIL_REGEX
	validates :firstname, length: { maximum: 255 }
	validates :lastname, length: { maximum: 255 }
	validates :password, presence: true, 
											 length: { in: 8..30 },
											 confirmation: true
	validates :password_confirmation, presence: true
	validates :avatar, file_size: { maximum: 2.megabytes.to_i }

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

	def votes
		total_votes = 0
		boards.each do |board|
			total_votes += board.votes
		end
		return total_votes
	end

	def generate_token(column)
		begin
			self[column] = SecureRandom.urlsafe_base64
		end while User.exists?(column => self[column])
	end

	def send_password_reset
		generate_token(:password_reset_token)
		self.password_reset_sent_at = Time.zone.now
		save!(validate: false)
		UserMailer.password_reset(self).deliver
	end

end
