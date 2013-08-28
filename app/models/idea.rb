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
#

class Idea < ActiveRecord::Base

	belongs_to :board

	validates :title, presence: true, uniqueness: true, length: { maximum: 255 }
	validates :content, presence: true
	validates :votes, numericality: { only_integer: true,
																		greater_than_or_equal_to: 0 }

	scope :popular, -> { order("votes desc") }
	#scope :recent, -> { order("updated_at desc") }

	def user
		board.user
	end
																	
end
