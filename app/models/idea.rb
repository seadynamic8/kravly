class Idea < ActiveRecord::Base

	belongs_to :board
	belongs_to :user

	validates :title, presence: true, uniqueness: true, length: { maximum: 255 }
	validates :content, presence: true
	validates :votes, numericality: { only_integer: true,
																		greater_than_or_equal_to: 0 }

	scope :popular, -> { order("votes desc") }
	#scope :recent, -> { order("updated_at desc") }
																	
end
