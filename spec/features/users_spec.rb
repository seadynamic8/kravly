require 'spec_helper'

feature 'User Management' do
	scenario "see signup page" do
		visit new_user_path
		expect(page).to have_css '#user_email'
		expect(page).to have_css '#user_password'
		# expect(page).to have_css '#user_password_confirmation'
		expect(page).to have_css '#user_firstname'
		expect(page).to have_css '#user_lastname'
		expect(page).to have_css 'input[type="hidden"]#user_display'
	end

	scenario "Logo link goes to discover page" do
		user = create(:user)
		log_in user
		visit discover_path
		within('.main-header') { click_link "Kravly" }
		expect(current_path).to eq discover_path
	end

	scenario "signup for a new member account" do
		visit discover_path
		expect {
			click_link "Sign Up"
			fill_in 'user[email]', with: 'newuser@example.com'
			fill_in 'user[password]', with: 'secret123'
			# fill_in 'Password Confirmation', with: 'secret123'
			click_button 'Create User'
		}.to change(User, :count).by(1)
		new_user = User.last
		expect(current_path).to eq discover_path
		expect(page).to have_content "Thank you for signing up!"
		expect(page).to have_content new_user.display_name
	end

	scenario "signup for a new member account without password" do
		visit discover_path
		expect {
			click_link "Sign Up"
			fill_in 'user[email]', with: 'newuser@example.com'
			click_button 'Create User'
		}.to_not change(User, :count).by(1)
		expect(current_path).to eq users_path
		expect(page).to have_css 'div.alert'
		expect(page).to have_css '#user_password'
		# expect(page).to have_css '#user_password_confirmation'
		expect(page).to have_css 'input[type="hidden"]#user_display'
	end

	scenario "signup for a new member account from home page" do
		visit root_url
		expect {
			fill_in 'user[email]', with: 'newuser@example.com'
			fill_in 'user[password]', with: 'secret123'
			click_button "Create Account"
		}.to change(User, :count).by(1)
		new_user = User.last
		expect(current_path).to eq boards_user_path(new_user)
		expect(page).to have_content "Thank you for signing up!"
		expect(page).to have_content new_user.display_name
	end

	scenario "cancel signup goes back to previous page" do
		visit discover_path
		click_link "Sign Up"
		click_link "Cancel"
		expect(current_path).to eq discover_path

		user = create(:user)
		visit boards_user_path(user)
		click_link "Sign Up"
		click_link "Cancel"
		expect(current_path).to eq boards_user_path(user)
	end

	scenario "see edit member account page" do 
		user = create(:user)
		log_in user
		visit edit_user_path(user)
		expect(page).to have_css '#user_username'
		expect(page).to have_css '#user_avatar'
		expect(page).to have_css 'input[type="hidden"]#user_avatar_cache'
		expect(page).to have_css '#user_about'
		expect(page).to have_css '#user_location'
		expect(page).to have_css '#user_website'
		expect(page).to have_css 'select#user_display'
	end

	scenario "edit a member account" do
		user = create(:user, email: "original@example.com")
		log_in user
		click_link "Settings"
		click_link "Edit Account"
		fill_in "Email", with: "updated@example.com"
		click_button "Update User"
		user.reload
		expect(user.email).to eq "updated@example.com"
		expect(current_path).to eq boards_user_path(user)
		expect(page).to have_content "Your account was updated."
		expect(page).to have_content user.display_name
	end

	scenario "edit a member account without email" do
		user = create(:user, email: "original@example.com")
		log_in user
		click_link "Settings"
		click_link "Edit Account"
		fill_in "Email", with: ""
		click_button "Update User"
		user.reload
		expect(user.email).to eq "original@example.com"
		expect(current_path).to eq user_path(user)
		expect(page).to have_css 'div.alert'
		expect(page).to have_css '#user_username'
		expect(page).to have_css 'select#user_display'
	end

	scenario "edit user's name display to email" do
		user = create(:user)
		log_in user
		visit edit_user_path(user)
		select "Email", from: "user_display"
		click_button "Update User"
		within('.user-header') { expect(page).to have_content user.email }
		within('.nav-list') { expect(page).to have_content user.email }
	end

	scenario "edit user's password" do
		user = create(:user, password: "secret123")
		log_in user
		visit change_password_user_path(user)
		fill_in "Old Password", with: "secret123"
		fill_in "New Password", with: "newsecret1234"
		fill_in "New Password Confirmation", with: "newsecret1234"
		click_button "Update Password"
		user.reload
		expect(current_path).to eq settings_user_path(user)
		expect(page).to have_content "Password successfully updated."
	end

	scenario "cancel edit goes back to previous page" do
		user = create(:user)
		log_in user
		click_link "Settings"
		click_link "Edit Account"
		click_link "Cancel"
		expect(current_path).to eq settings_user_path(user)
		
		visit boards_user_path(user)
		within('.user-header') { find('.edit-link').click }
		click_link "Cancel"
		expect(current_path).to eq boards_user_path(user)
	end

	scenario "delete a member account" do
		user = create(:user)
		log_in user
		expect {
			click_link "Settings"
			click_link "Delete Account"
		}.to change(User, :count).by(-1)
		expect(current_url).to eq root_url
	end

end