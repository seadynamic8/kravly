require 'spec_helper'

feature "Idea Management" do

	#In order to see ideas
	#As a user
	#I want to be able to manage my ideas

	scenario "create a new idea as a member" do
		user = create(:user_with_boards, admin: false)
		log_in user
		visit root_url
		within('.top-bar-section') do
			click_on "Idea" #Add New Idea
		end
		fill_in "Title", with: "FakeTitle"
		fill_in "idea_content", with: "FakeContent"
		click_on "Create Idea"
		expect(page).to have_content("Idea was created.")
		expect(page).to have_content("FakeTitle")
	end

	scenario "cannot edit idea as a guest" do
		idea = create(:idea, title: "Old Title")
		visit edit_idea_path(idea)
		expect(page).to have_content('Please login.')
	end

	scenario "updates the idea as admin" do
		user = create(:user, admin: true)
		idea = create(:idea, title: "Old Title")
		log_in user
		visit idea_path(idea)
		expect(page).to have_content("Old Title")
		click_on "Edit Idea"
		fill_in "Title", with: "New Title"
		click_on "Update Idea"
		expect(page).to have_content("Idea was updated.")
		expect(page).to have_content("New Title")
		expect(page).to_not have_content("Old Title")
	end

	scenario "destroys idea as admin" do
		user = create(:user, admin: true)
		idea = create(:idea, title: "Oops")
		log_in user
		visit idea_path(idea)
		expect(page).to have_content("Oops")
		click_on "Delete"
		expect(page).to have_content("Idea was deleted.")
		expect(page).to_not have_content("Oops")
	end

	scenario "edit owned idea as member" do
		user = create(:user)
		board = create(:board, user: user)
		idea = create(:idea, board: board)
		log_in user
		visit edit_idea_path(idea)
		expect(page).to_not have_content("Please login.")
	end

end