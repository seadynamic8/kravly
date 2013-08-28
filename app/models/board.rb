# == Schema Information
#
# Table name: boards
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#  description :string(255)
#

class Board < ActiveRecord::Base

	belongs_to :user
	has_many :ideas, dependent: :destroy

	validates :name, presence:true, uniqueness: true, length: { maximum: 255 }

	def votes
		total_votes = 0
		ideas.each do |idea|
			total_votes += idea.votes
		end
		return total_votes
	end

end
