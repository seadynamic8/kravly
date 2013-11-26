# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  slug       :string(255)
#

require 'spec_helper'

describe Category do
  
  describe "relationships" do
		it { should have_many(:boards) }
	end

	describe "validations" do

		it { should normalize_attribute(:name) }

		it { should validate_presence_of(:name) }
		it { should validate_uniqueness_of(:name) }
	end
end
