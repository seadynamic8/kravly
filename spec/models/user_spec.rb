require 'spec_helper'

describe User do
	it "is valid with a username, email, firstname, lastname" do
		expect(create(:user)).to be_valid
	end

	it "is invalid without a username" do
		expect(build(:user, username: nil)).to have(1).errors_on(:username)
	end

	it "is invalid without an email" do
		end
	it "is invalid without a firstname"
	it "is invalid without a lastname"
	it 'returns the full name as a string'
end
