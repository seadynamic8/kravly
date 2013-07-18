require 'spec_helper'

describe Board do
  
  describe "relationships" do
		it { should belong_to(:user) }
		it { should have_and_belong_to_many(:ideas) }
	end

	describe "validations" do

		it { should validate_presence_of(:name) }
		it { should validate_uniqueness_of(:name) }
		it "is invalid with a name greater than 255 length" do
			expect(build(:board, name: "a" * 256)).to have(1).errors_on(:name)
		end
	end
end
