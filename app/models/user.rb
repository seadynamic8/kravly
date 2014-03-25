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
#  avatar                 :string(255)
#  slug                   :string(255)
#  admin                  :boolean          default(FALSE)
#  about                  :text
#  location               :string(255)
#  website                :string(255)
#  display                :integer
#  notify_vote            :boolean          default(TRUE)
#  notify_comment         :boolean          default(TRUE)
#

require 'file_size_validator'

class User < ActiveRecord::Base
	has_secure_password

	has_many :boards, dependent: :destroy
	has_many :user_votes, dependent: :destroy

	include FriendlyId
	friendly_id :username, use: :slugged

	mount_uploader :avatar, AvatarUploader

	normalize_attributes :username, :email, :firstname, :lastname

	EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	attr_accessor :updating_password

	validates :username, uniqueness: true, 
											 length: { in: 3..40 },
											 format: { with: /\A[A-Za-z\d\._-]+\z/, 
											 message: "can only contain alphanumeric, dot, underscore, or hyphen with no spaces" }
	validates :email, presence: true, uniqueness: true, format: EMAIL_REGEX
	validates :firstname, length: { maximum: 35 }
	validates :lastname, length: { maximum: 35 }
	validates :password, presence: true, 
											 length: { in: 8..30 },
											 # confirmation: true,
											 if: :should_validate_password?
	validates :password_confirmation, presence: true,
											if: :should_validate_password_confirmation?
	validates :avatar, file_size: { maximum: 2.megabytes.to_i }
	validates :slug, uniqueness: true, allow_nil: true
	validates :location, length: { maximum: 50 }
	validates :website, length: { maximum: 50 }
	validates :display, presence: true, inclusion: { in: [1, 2, 3] }

	before_validation :copy_password_to_confirmation, on: :create
	before_validation :ensure_username_uniqueness, on: :create
	after_validation :move_friendly_id_error_to_username
	before_create :set_display_to_fullname_if_exist, on: :create
	after_create :generate_slug, on: :create

	scope :newly_created, -> { order("created_at desc") }
	
	def display_name(newline = false)
		case display
		when 1
			newline ? "#{firstname}\n#{lastname}" : "#{firstname} #{lastname}"
		when 2
			"#{username}"
		when 3
			"#{email}"
		end
	end

	def name
		firstname.blank? ? username : "#{firstname}"
	end

	def votes
		# boards.inject(0) { |total, board| total + board.votes }
		user_votes.count
	end

	def not_voted?(idea)
		self.user_votes.each do |user_vote|
			return false if user_vote.idea_id == idea.id
		end
		true
	end

	def ideas
		board_ids = boards.map { |b| b.id }
		Idea.where(board_id: board_ids)
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

	def should_generate_new_friendly_id?
		slug.blank? || username_changed?
	end

	def password_match?(user_params)
		user_params[:password] == user_params[:password_confirmation] && 
				!user_params[:password_confirmation].blank?
	end

	private

		def should_validate_password?
		  updating_password || new_record?
		end

		def should_validate_password_confirmation?
			updating_password
		end

		# Used only on create
		# This is unfortunately needed because has_secure_password requires a
		# password_confirmation, when I dont want to use that on create.
		def copy_password_to_confirmation
			self.password_confirmation = self.password
		end

		def ensure_username_uniqueness
			if email && ( self.username.blank? || User.find_by_username(self.username) )
				username_part = self.email.split("@").first
				new_username = username_part.dup 
				num = 1
				while(User.find_by_username(new_username))
					new_username = "#{username_part}-#{num+=1}"
				end
				self.username = new_username
			end
		end

		def set_display_to_fullname_if_exist
			self.display = 1 if firstname.present?
		end

		def move_friendly_id_error_to_username
			errors.add :username, *errors.delete(:friendly_id) if errors[:friendly_id].present?
		end

		def generate_slug
			save
		end

end
