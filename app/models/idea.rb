# == Schema Information
#
# Table name: ideas
#
#  id                 :integer          not null, primary key
#  title              :string(255)
#  content            :text
#  votes              :integer
#  created_at         :datetime
#  updated_at         :datetime
#  board_id           :integer
#  image              :string(255)
#  video_url          :string(255)
#  video_type         :string(255)
#  slug               :string(255)
#  contribution_level :string(255)
#  source             :string(255)
#

require 'file_size_validator'
require 'uri'

class Idea < ActiveRecord::Base
	acts_as_commentable

	belongs_to :board

	include FriendlyId
	friendly_id :slug_candidates, use: [:slugged, :history]

	before_save :sanitize_video_url, if: :video_url?

	mount_uploader :image, ImageUploader

	normalize_attributes :title, :content, :contribution_level

	validates :title, presence: true, uniqueness: true, length: { maximum: 45 }
	validates :content, presence: true
	validates :votes, numericality: { only_integer: true,
																		greater_than_or_equal_to: 0 }
	validates :image, file_size: { maximum: 2.megabytes.to_i }
	validates :board, presence: true
	validates :contribution_level, length: { maximum: 30 }

	after_validation :move_friendly_id_error_to_name
	before_save :update_source_from_remote_url

	include PgSearch
	pg_search_scope :search, 
									against: :title,
  								using: { tsearch: { dictionary: 'english' } }

	scope :popular, -> { order("votes desc") }
	scope :recent, -> { order("updated_at desc") }

	def user
		board.user
	end

	def slug_candidates
		[ :title,
			[:id, :title]
		]
	end

	def self.text_search(query)
		if query.present?
			search(query)
		else
			scoped
		end
	end

	def should_generate_new_friendly_id?
		new_record? || title.blank? || title_changed?
	end

	private

		def sanitize_video_url
			uri = URI(self.video_url)
			self.video_url = ["http://", uri.host, uri.path].join
		end

		def move_friendly_id_error_to_name
			errors.add :name, *errors.delete(:friendly_id) if errors[:friendly_id].present?
		end

		def update_source_from_remote_url
			self.source = URI(self.remote_image_url).host if self.remote_image_url
		end
																	
end
