class Board < ActiveRecord::Base

	belongs_to :user
	has_many :ideas

	validates :name, presence:true, uniqueness: true, length: { maximum: 255 }

end
