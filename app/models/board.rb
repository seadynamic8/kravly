class Board < ActiveRecord::Base

	belongs_to :user
	has_many :ideas, dependent: :destroy

	validates :name, presence:true, uniqueness: true, length: { maximum: 255 }

end
