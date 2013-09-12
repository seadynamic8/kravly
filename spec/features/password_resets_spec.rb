require 'spec_helper'

feature "Password Resets" do

	before(:each) do
		reset_email
	end

	scenario "Emails a user when requesting password reset" do
		user = create(:user)
		visit login_path
		click_link "Forgot Password?"
		fill_in "Email", with: user.email
		click_button "Reset Password"
		expect(page).to have_content("Email sent")
		expect(last_email.to).to include(user.email)
	end

	scenario "Doesn't emails an invalid user when requesting password reset" do
		visit login_path
		click_link "Forgot Password?"
		fill_in "Email", with: "madeupuser@example.com"
		click_button "Reset Password"
		expect(page).to have_content("Email not found!")
		expect(last_email).to be_nil
	end
end