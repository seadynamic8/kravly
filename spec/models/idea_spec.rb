# == Schema Information
#
# Table name: ideas
#
#  id                 :integer          not null, primary key
#  title              :string(255)
#  content            :text
#  votes              :integer
#  created_at         :datetime
#  updated_at         :datetime
#  board_id           :integer
#  image              :string(255)
#  video_url          :string(255)
#  video_type         :string(255)
#  slug               :string(255)
#  contribution_level :string(255)
#  source             :string(255)
#

require 'spec_helper'

describe Idea do
  
  describe "relationships" do
		it { should belong_to(:board) }
	end

	describe "validations" do

		it { should normalize_attribute(:title) }
		it { should normalize_attribute(:content) }
		it { should normalize_attribute(:contribution_level) }

		it { should validate_presence_of(:title) }
		it { should validate_uniqueness_of(:title) }
		it { should ensure_length_of(:title).is_at_most(45) }

		it { should validate_presence_of(:content) }

		it { should validate_numericality_of(:votes) }
		it "is invalid with a negative number" do
			expect(build(:idea, votes: -1)).to have(1).errors_on(:votes)
		end

		it { should validate_presence_of(:board) }

		it { should ensure_length_of(:contribution_level).is_at_most(30) }
	end

	describe "functions" do

		it "should return idea's boards user as a user method under idea" do
			idea = create(:idea)
			expect(idea.user).to eq idea.board.user
		end
	end


end
