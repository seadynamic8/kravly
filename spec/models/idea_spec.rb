require 'spec_helper'

describe Idea do
  
  describe "relationships" do
		it { should have_and_belong_to_many(:boards) }
	end

	describe "validations" do

		it { should validate_presence_of(:title) }
		it { should validate_uniqueness_of(:title) }
		it "is invalid with a name greater than 255 length" do
			expect(build(:idea, title: "a" * 256)).to have(1).errors_on(:title)
		end

		it { should validate_presence_of(:content) }

		it { should validate_numericality_of(:votes) }
		it "is invalid with a negative number" do
			expect(build(:idea, votes: -1)).to have(1).errors_on(:votes)
		end
	end

	describe "functions" do

		it "should return idea's boards first user as a user method under idea" do
			idea = create(:idea_with_boards)
			expect(idea.user).to eq idea.boards.first.user
		end
	end


end
