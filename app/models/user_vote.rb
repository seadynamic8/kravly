# == Schema Information
#
# Table name: user_votes
#
#  id         :integer          not null, primary key
#  idea_id    :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class UserVote < ActiveRecord::Base

	belongs_to :user

	validates :idea_id, presence: true, numericality: { only_integer: true }
	validates :user_id, numericality: { only_integer: true }

	def idea
		Idea.find(idea_id)
	end

end
