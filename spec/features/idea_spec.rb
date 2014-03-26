require 'spec_helper'

feature "Idea Management" do

	context "as a guest" do

		scenario "cannot edit idea" do
			idea = create(:idea, title: "Old Title")
			visit edit_idea_path(idea)
			expect(page).to have_content('Please login.')
		end

		scenario "can see idea info if set" do
			idea = create(:idea, commitment: "Contribute Initial Idea Only",
				looking_for: ["Partners/Co-Founders"], market: "New York")
			visit idea_path(idea)
			expect(page).to have_content("Contribute Initial Idea Only")
			expect(page).to have_content("Partners/Co-Founders")
			expect(page).to have_content("New York")
		end


	end

	context "as a member" do

		let(:user) { create(:user) }
		let(:board) { create(:board, user: user) }
		let(:idea) { create(:idea, board: board) }
		before(:each) { log_in user }

		scenario "sees add a new idea page" do
			board
			visit new_idea_path
			expect(page).to have_css '#idea_title'
			expect(page).to have_css '#idea_image'
			expect(page).to have_css '#idea_remote_image_url'
			expect(page).to have_css 'input[type="hidden"]#idea_image_cache'
			expect(page).to have_css '#idea_video_url'
			expect(page).to have_css '#idea_content'
			expect(page).to have_css '#idea_board_id'
			expect(page).to have_css '#idea_commitment'
			expect(page).to have_css 'label[for="idea_looking_for"]'
			expect(page).to have_css '#idea_market'
			expect(page).to have_css 'input[value="0"]#idea_votes'
		end

		scenario "ads a new idea with no initial boards will redirect to board#new" do
			within('.top-bar-section') { click_on "Idea" }
			expect(current_path).to eq new_user_board_path(user)
			expect(page).to have_content("Please create a board first.")
		end

		scenario "add a new idea" do
			board
			expect {
				within('.top-bar-section') { click_on "Idea" }
				fill_in "Title", with: "FakeTitle"
				fill_in "idea_content", with: "FakeContent"
				click_on "Create Idea"
			}.to change(Idea, :count).by(1)
			idea = Idea.last
			expect(current_path).to eq idea_path(idea)
			expect(page).to have_content("Idea was created.")
			expect(page).to have_content("FakeTitle")
		end

		scenario "doesn't add a new idea without invalid attributes" do
			board
			within('.top-bar-section') { click_on "Idea" }
			click_on "Create Idea"
			expect(current_path).to eq ideas_path
			expect(page).to have_css('div.alert')
			expect(page).to have_css 'input[value="0"]#idea_votes'
		end

		scenario "cancel add goes back to previous page" do
			within('.top-bar-section') { click_on "Idea" }
			click_link "Cancel"
			expect(current_path).to eq discover_path

			visit boards_user_path(user)
			within('.top-bar-section') { click_on "Idea" }
			click_link "Cancel"
			expect(current_path).to eq boards_user_path(user)
		end

		scenario "sees the edit idea page" do
			visit edit_idea_path(idea)
			expect(page).to have_css "input[value='#{idea.votes}']#idea_votes"
		end

		scenario "edit idea from users#ideas page" do
			idea = create(:idea, board: board, title: "Old Title")
			click_link "Your Ideas"
			within("#idea-#{idea.id}") { find('.edit-link').click }
			fill_in "Title", with: "New Title"
			click_button "Update Idea"
			idea.reload
			expect(idea.title).to eq "New Title"
		end

		scenario "edit idea from ideas#show page" do
			idea = create(:idea, board: board, title: "Old Title")
			click_link "Your Ideas"
			click_link "#{idea.title}"
			find('#edit-button').click
			fill_in "Title", with: "New Title"
			click_button "Update Idea"
			idea.reload
			expect(idea.title).to eq "New Title"
		end

		scenario "edit idea from boards#show page" do
			idea = create(:idea, board: board, title: "Old Title")
			click_link "Your Boards"
			click_link "#{board.name}"
			within("#idea-#{idea.id}") { find('.edit-link').click }
			fill_in "Title", with: "New Title"
			click_button "Update Idea"
			idea.reload
			expect(idea.title).to eq "New Title"
		end

		scenario "edit idea without title" do
			visit edit_idea_path(idea)
			fill_in "Title", with: ""
			click_button "Update Idea"
			expect(page).to have_css 'div.alert'
			expect(page).to have_css "input[value='#{idea.votes}']#idea_votes"
		end

		scenario "cancel edit goes back to previous page" do
			visit idea_path(idea)
			find('#edit-button').click
			click_link "Cancel"
			expect(current_path).to eq idea_path(idea)

			visit user_board_path(user, board)
			within("#idea-#{idea.id}") { find('.edit-link').click }
			click_link "Cancel"
			expect(current_path).to eq user_board_path(user, board)
		end

		scenario "edit user's own idea to be authorized" do
			visit edit_idea_path(idea)
			expect(page).to_not have_content("Please login.")
		end

		scenario "deletes idea from ideas#show page" do
			idea
			expect {
				click_link "Your Ideas"
				click_link "#{idea.title}"
				find('#delete-button').click
			}.to change(Idea, :count).by(-1)
			expect(current_path).to eq user_board_path(user, board)
			expect(page).to have_content "Idea was deleted."
		end

		scenario "deletes idea from users#ideas page" do
			idea
			expect {
				click_link "Your Ideas"
				within("#idea-#{idea.id}") { find('.delete-link').click }
			}.to change(Idea, :count).by(-1)
			expect(current_path).to eq user_board_path(user, board)
			expect(page).to have_content "Idea was deleted."
		end

		scenario "deletes idea from boards#show page" do
			idea
			expect {
				visit user_board_path(user, board)
				within("#idea-#{idea.id}") { find('.delete-link').click }
			}.to change(Idea, :count).by(-1)
			expect(current_path).to eq user_board_path(user, board)
			expect(page).to have_content "Idea was deleted."
		end

		scenario "adds a vote to another user's idea" do
			other_user = create(:user)
			other_board = create(:board, user: other_user)
			other_idea = create(:idea, board: other_board)
			other_idea_votes = other_idea.votes

			visit idea_path(other_idea)
			find('#like-button').click
			other_idea.reload
			expect(other_idea.votes).to eq other_idea_votes + 1
			expect(current_path).to eq idea_path(other_idea)
			within('.sidebar .idea-stats .vote') do
				expect(page).to have_content "#{other_idea_votes + 1}"
			end
		end

		# scenario "adds a vote using sidebar" do
		# 	other_user = create(:user)
		# 	other_board = create(:board, user: other_user)
		# 	other_idea = create(:idea, board: other_board)
		# 	other_idea_votes = other_idea.votes
			
		# 	visit idea_path(other_idea)
		# 	find('#like-button').click
		# 	other_idea.reload
		# 	expect(other_idea.votes).to eq other_idea_votes + 1
		# end

		scenario "can't add a vote to user's own idea" do
			visit idea_path(idea)
			within('.idea-overview') { expect(page).to_not have_link "Vote" }
		end

		scenario "can't add more than 1 vote" do
			other_user = create(:user)
			other_board = create(:board, user: other_user)
			other_idea = create(:idea, board: other_board)
			other_idea_votes = other_idea.votes
			
			visit idea_path(other_idea)
			find('#like-button').click
			other_idea.reload
			expect(page).to have_css "#like-button.disabled"
		end
	end

	context "as a admin" do

		let(:user) { create(:user, admin: true) }

		scenario "updates the idea" do
			idea = create(:idea, title: "Old Title")
			log_in user
			visit idea_path(idea)
			expect(page).to have_content("Old Title")
			find('#edit-button').click
			fill_in "Title", with: "New Title"
			click_on "Update Idea"
			expect(page).to have_content("Idea was updated.")
			expect(page).to have_content("New Title")
			expect(page).to_not have_content("Old Title")
		end

		scenario "destroys idea" do
			idea = create(:idea, title: "Oops")
			log_in user
			visit idea_path(idea)
			expect(page).to have_content("Oops")
			find('#delete-button').click
			expect(page).to have_content("Idea was deleted.")
			expect(page).to_not have_content("Oops")
		end
	end

end