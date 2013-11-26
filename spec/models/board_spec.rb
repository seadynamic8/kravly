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
#  slug        :string(255)
#  category_id :integer
#

require 'spec_helper'

describe Board do
  
  describe "relationships" do
  	it { should belong_to(:category) }
		it { should belong_to(:user) }
		it { should have_many(:ideas) }
	end

	describe "validations" do

		it { should normalize_attribute(:name) }
		it { should normalize_attribute(:description) }

		it { should validate_presence_of(:name) }
		it { should validate_uniqueness_of(:name) }
		it { should ensure_length_of(:name).is_at_most(30) }

		it { should ensure_length_of(:description).is_at_most(255) }

		it { should validate_presence_of(:user_id) }
		it { should validate_presence_of(:category_id) }
	end

	describe "functions" do

		it "should return votes as a total of the ideas' votes" do
			board = create(:board_with_ideas)
			total = 0
			board.ideas.map { |idea| total += idea.votes }
			expect(board.votes).to eq total
		end
	end
end
