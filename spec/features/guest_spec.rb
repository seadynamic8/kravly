require 'spec_helper'

feature "Guest Actions" do

	context "[user, board, idea]" do

		let(:user) { create(:user) }
		let(:board) { create(:board, user: user) }
		let!(:idea) { create(:idea, board: board) }

		scenario "view idea on home page" do
			visit root_url
			expect(page).to have_content idea.title
			expect(page).to have_content idea.votes
			expect(page).to have_content user.fullname
		end

		scenario "view specific idea from home page" do
			visit root_url
			click_link "#{idea.title}"
			expect(current_path).to eq idea_path(idea)
			expect(page).to have_content idea.title
			expect(page).to have_content idea.votes
			expect(page).to have_content user.fullname
			expect(page).to have_content board.name
			expect(page).to have_content "Comments"
		end

		scenario "view all user's boards from home page" do
			visit root_url
			click_link user.fullname
			expect(current_path).to eq boards_user_path(user)
			expect(page).to have_content user.fullname
			within('.user-stats') do
				expect(page).to have_content user.boards.count
				expect(page).to have_content user.ideas.count
				expect(page).to have_content user.votes
			end
			expect(page).to have_content board.name
		end

		scenario "view all user's ideas from all user's boards" do
			visit boards_user_path(user)
			within('.user-stats') { click_link "Ideas" }
			expect(current_path).to eq ideas_user_path(user)
			expect(page).to have_content user.fullname
			within('.user-stats') do
				expect(page).to have_content user.boards.count
				expect(page).to have_content user.ideas.count
				expect(page).to have_content user.votes
			end
			expect(page).to have_content idea.title
		end

		scenario "view all user's boards from all user's ideas" do
			visit ideas_user_path(user)
			within('.user-stats') { click_link "Boards" }
			expect(current_path).to eq boards_user_path(user)
			expect(page).to have_content board.name
		end

		scenario "view specific board from home page" do
			visit root_url
			click_link user.fullname
			click_link "#{board.name}"
			expect(current_path).to eq user_board_path(user, board)
			expect(page).to have_content board.name
			within('.group-header-stats') do
				expect(page).to have_content user.fullname
				expect(page).to have_content board.votes
			end
			expect(page).to have_content idea.title
		end

		scenario "view specific idea from specific board page" do
			visit user_board_path(user, board)
			click_link "#{idea.title}"
			expect(current_path).to eq idea_path(idea)
			expect(page).to have_content idea.title
		end

		scenario "go back to specific board page from specific idea" do
			visit idea_path(idea)
			click_link "#{board.name}"
			expect(current_path).to eq user_board_path(user, board)
			expect(page).to have_content board.name
		end

		scenario "go back to all users boards from specific board" do
			visit user_board_path(user, board)
			click_link "#{user.fullname}"
			expect(current_path).to eq boards_user_path(user)
			expect(page).to have_content user.fullname
		end

		scenario "search for idea returns matched result" do
			create(:idea, board: board, title: "Cool Idea")
			visit root_url
			fill_in "query", with: "Cool Idea"
			click_button "Search"
			expect(current_path).to eq ideas_path
			expect(page).to have_content "Cool Idea"
		end

	end

end
