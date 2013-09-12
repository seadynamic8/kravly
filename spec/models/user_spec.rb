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
#  slug                   :string(255)
#  admin                  :boolean          default(FALSE)
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

		# it "in invalid with avatar being greater than 2MB in size"
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

		it "should return votes as a total of the boards' votes" do
			user = create(:user_with_boards)
			total = 0
			user.boards.map { |board| total += board.votes }
			expect(user.votes).to eq total
		end

		it "should return all the ideas belonging to the user" do
			user = create(:user_with_boards)
			board_ids = user.boards.map { |b| b.id }
			ideas = Idea.where(board_id: board_ids)
			expect(user.ideas).to eq ideas
		end

		context "send_password_reset" do
			let(:user) { create(:user) }

			it "generates a unique password_reset_token each time" do
				user.send_password_reset
				last_token = user.password_reset_token
				user.send_password_reset
				expect(user.password_reset_token).to_not eq(last_token)
			end

			it "saves the time the password reset was sent" do
				user.send_password_reset
				expect(user.reload.password_reset_sent_at).to be_present
			end

			it "delivers email to user" do
				user.send_password_reset
				expect(last_email.to).to include(user.email)
			end
		end

	end

end
	
