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

require 'spec_helper'

describe UserVote do
  
  describe "relationships" do
		it { should belong_to(:user) }
	end

	describe "validations" do
		it { should validate_presence_of(:idea_id) }
		it { should validate_numericality_of(:idea_id) }

		it { should validate_numericality_of(:user_id) }
	end

	describe "functions" do

		it "should return Idea object when calling idea" do
			user = create(:user)
			other_idea = create(:idea)
			UserVote.create(idea_id: other_idea.id, user: user)
			expect(user.user_votes.first.idea).to be_an_instance_of(Idea)
		end
	end
end
