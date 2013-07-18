class Board < ActiveRecord::Base

	belongs_to :user
	has_and_belongs_to_many :ideas

	validates :name, presence:true, uniqueness: true, length: { maximum: 255 }

end
