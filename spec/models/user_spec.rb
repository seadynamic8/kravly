require 'spec_helper'

describe User do

	describe "relationships" do
		it { should have_many(:boards) }
	end

	describe "validations" do
		it "is valid with a username, email, firstname, lastname" do
			expect(create(:user)).to be_valid
		end

		it "is invalid without a username" do
			expect(build(:user, username: nil)).to have(1).errors_on(:username)
		end

		it "is invalid without an email" do
			expect(build(:user, email: nil)).to be_invalid
		end

		it "is invalid without a firstname" do
			expect(build(:user, firstname: nil)).to have(1).errors_on(:firstname)
		end

		it "is invalid without a lastname" do
			expect(build(:user, lastname: nil)).to have(1).errors_on(:lastname)
		end

		it 'returns the full name as a string' do
			user = create(:user)
			expect(user.fullname).to eq "#{user.firstname} #{user.lastname}"
		end

		it "is invalid with duplicate email addresses" do
			create(:user, email: 'jsmith@example.com')
			expect(build(:user, email: 'jsmith@example.com')).to have(1).errors_on(:email)
		end

		it "is invalid with duplicate usernames" do
			create(:user, username: 'jsmith')
			expect(build(:user, username: 'jsmith')).to have(1).errors_on(:username)
		end

		it "is invalid with a username greater than 255 length" do
			expect(build(:user, username: "a"*256)).to have(1).errors_on(:username)
		end

		it "is invalid with a firstname greater than 255 length" do
			expect(build(:user, firstname: "a"*256)).to have(1).errors_on(:firstname)
		end

		it "is invalid with a lastname greater than 255 length" do
			expect(build(:user, lastname: "a"*256)).to have(1).errors_on(:lastname)
		end

		#it "is invalid with email badly formated (regex)" do
			# invalid_logins = ["b lah","bälah","b@lah","bülah","bßlah","b!lah","b%lah","b)lah"]
			# invalid_logins.each do |s|
			#   it { should_not allow_value(s).for(:email) }
			# end
		#end
	end

end
	
