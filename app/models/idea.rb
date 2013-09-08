# == Schema Information
#
# Table name: ideas
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text
#  votes      :integer
#  created_at :datetime
#  updated_at :datetime
#  board_id   :integer
#  image      :string(255)
#  video_url  :string(255)
#  video_type :string(255)
#

require 'file_size_validator'
require 'uri'

class Idea < ActiveRecord::Base
	acts_as_commentable

	belongs_to :board

	before_save :sanitize_video_url, if: :video_url?

	mount_uploader :image, ImageUploader

	normalize_attributes :title, :content

	validates :title, presence: true, uniqueness: true, length: { maximum: 255 }
	validates :content, presence: true
	validates :votes, numericality: { only_integer: true,
																		greater_than_or_equal_to: 0 }
	validates :image, file_size: { maximum: 2.megabytes.to_i }

	include PgSearch
	pg_search_scope :search, 
									against: :title,
  								using: { tsearch: { dictionary: 'english' } }

	scope :popular, -> { order("votes desc") }
	#scope :recent, -> { order("updated_at desc") }

	def user
		board.user
	end

	def self.text_search(query)
		if query.present?
			search(query)
		else
			scoped
		end
	end

	private

		def sanitize_video_url
			uri = URI(self.video_url)
			self.video_url = ["http://", uri.host, uri.path].join
		end
																	
end
