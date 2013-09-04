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
#

require 'file_size_validator'

class Idea < ActiveRecord::Base

	belongs_to :board

	mount_uploader :image, ImageUploader

	normalize_attributes :title, :content

	validates :title, presence: true, uniqueness: true, length: { maximum: 255 }
	validates :content, presence: true
	validates :votes, numericality: { only_integer: true,
																		greater_than_or_equal_to: 0 }
	validates :image, file_size: { maximum: 2.megabytes.to_i }

	scope :popular, -> { order("votes desc") }
	#scope :recent, -> { order("updated_at desc") }

	def user
		board.user
	end
																	
end
