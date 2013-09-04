# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  username               :string(255)
#  email                  :string(255)
#  firstname              :string(255)
#  lastname               :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  password_digest        :string(255)
#  password_reset_token   :string(255)
#  password_reset_sent_at :datetime
#  avatar                 :string(255)
#

require 'spec_helper'

describe User do

	describe "relationships" do
		it { should have_many(:boards) }
	end

	describe "validations" do

		it { should normalize_attribute(:username) }
		it { should normalize_attribute(:email) }
		it { should normalize_attribute(:firstname) }
		it { should normalize_attribute(:lastname) }

		it "is valid with a username, email, firstname, lastname" do
			expect(create(:user)).to be_valid
		end

		#it { should validate_uniqueness_of(:username) } #Bug in shoulda for Rails 4
		it "is invalid with duplicate usernames" do
			create(:user, username: 'jsmith')
			expect(build(:user, username: 'jsmith')).to have(1).errors_on(:username)
		end
		it { should ensure_length_of(:username).is_at_most(255) }


		it { should validate_presence_of(:email) }
		#it { should validate_uniqueness_of(:email) } #Bug in shoulda for Rails 4
		it "is invalid with duplicate email addresses" do
			create(:user, email: 'jsmith@example.com')
			expect(build(:user, email: 'jsmith@example.com')).to have(1).errors_on(:email)
		end
		# it "is invalid with email badly formated (regex)" do
		# 	invalid_logins = ["b lah","bälah","b@lah","bülah","bßlah","b!lah","b%lah","b)lah"]
		# 	invalid_logins.each do |s|
		# 	  it { should_not allow_value(s).for(:email) }
		# 	end
		# end

		it { should ensure_length_of(:firstname).is_at_most(255) }
		it { should ensure_length_of(:lastname).is_at_most(255) }

		it { should validate_presence_of(:password) }
		it { should ensure_length_of(:password).
									is_at_least(8).
									is_at_most(30) }
		# it { should validate_confirmation_of(:password) }
		it { should validate_presence_of(:password_confirmation) }
	end

	describe "functions" do

		it "returns the full name as a string if firstname and lastname are set" do
			user = create(:user)
			expect(user.fullname).to eq "#{user.firstname} #{user.lastname}"
		end

		it "returns the username as a string if firstname and lastname aren't set" do
			user = create(:user)
			user.firstname = nil
			user.lastname = nil
			expect(user.fullname).to eq "#{user.username}"
		end

		it "return the email if both username and first and last name aren't set" do
			user = create(:user)
			user.firstname = nil
			user.lastname = nil
			user.username = nil
			expect(user.fullname).to eq "#{user.email}"
		end

		it "should return votes as a total of the boards' votes" do
			user = create(:user_with_boards)
			total_votes = 0
			user.boards.each do |board|
				total_votes += board.votes
			end
			expect(user.votes).to eq total_votes
		end

	end

end
	
