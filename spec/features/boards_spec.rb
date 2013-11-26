require 'spec_helper'

feature "Board Management" do

	context "as a member" do

		let!(:category) { create(:category, name: "Test Category") }
		let(:user) { create(:user) }
		before(:each) { log_in user }

		scenario "sees add new board page" do
			visit new_user_board_path(user)
			expect(page).to have_css '#board_name'
			expect(page).to have_css '#board_description'
			expect(page).to have_css 'input[type="hidden"]#board_user_id'
		end

		scenario "adds a new board" do
			expect {
				within('.top-bar-section') { click_link "Board" }
				fill_in "Name", with: "Board Name"
				select "Test Category", from: 'board_category_id'
				click_button "Create Board"
			}.to change(Board, :count).by(1)
			new_board = Board.last
			expect(current_path).to eq user_board_path(new_board.user, new_board)
			expect(page).to have_content "Board was created."
			expect(page).to have_content new_board.name
		end

		scenario "doesn't add a new board without a name" do
			expect {
				within('.top-bar-section') { click_link "Board" }
				click_button "Create Board"
			}.to_not change(Board, :count).by(1)
			expect(current_path).to eq user_boards_path(user)
			expect(page).to have_css('div.alert')
		end

		scenario "goes back to previous page if cancel adding a board" do
			within('.top-bar-section') { click_link "Board" }
			click_link "Cancel"
			expect(current_url).to eq root_url

			visit boards_user_path(user)
			within('.top-bar-section') { click_link "Board" }
			click_link "Cancel"
			expect(current_path).to eq boards_user_path(user)
		end

		scenario "edits a board from users#boards page" do
			board = create(:board, user: user, name: "Original Board Name")
			click_link "Your Boards"
			within("#board-#{board.id}") { click_link "Edit" }
			fill_in "Name", with: "New Board Name"
			click_button "Update Board"
			board.reload
			expect(board.name).to eq "New Board Name"
		end

		scenario "edits a board from boards#show page" do
			board = create(:board, user: user, name: "Original Board Name")
			click_link "Your Boards"
			click_link "#{board.name}"
			click_link "Edit Board"
			fill_in "Name", with: "New Board Name"
			click_button "Update Board"
			board.reload
			expect(board.name).to eq "New Board Name"
		end

		scenario "edits a board without a blank board name" do
			board = create(:board, user: user)
			visit edit_user_board_path(user, board)
			fill_in "Name", with: ""
			click_button "Update Board"
			expect(page).to have_css 'div.alert'
		end

		scenario "goes back to previous page if cancel editing a board" do
			board = create(:board, user: user)
			click_link "Your Boards"
			within("#board-#{board.id}") { click_link "Edit" }
			click_link "Cancel"
			expect(current_path).to eq boards_user_path(user)
			
			click_link "#{board.name}"
			click_link "Edit Board"
			click_link "Cancel"
			expect(current_path).to eq user_board_path(user, board)
		end

		scenario "deletes a board from users#boards page" do
			board = create(:board, user: user, name: "Original Board Name")
			expect {
				click_link "Your Boards"
				within("#board-#{board.id}") { click_link "Delete" }
			}.to change(Board, :count).by(-1)
			expect(current_path).to eq boards_user_path(user)
			expect(page).to have_content "Board was deleted."
		end
	end
end