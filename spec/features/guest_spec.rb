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
			expect(page).to have_content user.display_name
		end

		scenario "view most recent ideas on home page" do
			visit root_url
			click_link "Recently Updated"
			expect(page).to have_content idea.title
		end

		scenario "view specific idea from home page" do
			visit root_url
			click_link "#{idea.title}"
			expect(current_path).to eq idea_path(idea)
			expect(page).to have_content idea.title
			expect(page).to have_content idea.votes
			expect(page).to have_content user.display_name
			expect(page).to have_content board.name
			# expect(page).to have_content "Contribution Level"
			expect(page).to have_content "Comments"
		end

		scenario "view all user's boards from home page" do
			visit root_url
			click_link user.display_name
			expect(current_path).to eq boards_user_path(user)
			expect(page).to have_content user.display_name
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
			expect(page).to have_content user.display_name
			within('.user-stats') do
				expect(page).to have_content user.boards.count
				expect(page).to have_content user.ideas.count
				expect(page).to have_content user.votes
			end
			expect(page).to have_content idea.title
		end

		scenario "view all user's voted ideas from all user's boards" do
			other_user = create(:user)
			other_board = create(:board, user: other_user)
			other_idea = create(:idea, board: other_board)
			UserVote.create(idea_id: other_idea.id, user: user)

			visit boards_user_path(user)
			within('.user-stats') { click_link "Votes" }
			expect(current_path).to eq votes_user_path(user)
			expect(page).to have_content user.display_name
			within('.user-stats') do
				expect(page).to have_content user.boards.count
				expect(page).to have_content user.ideas.count
				expect(page).to have_content user.votes
			end
			expect(page).to have_content other_idea.title
		end

		scenario "view all user's voted ideas from all user's ideas" do
			other_user = create(:user)
			other_board = create(:board, user: other_user)
			other_idea = create(:idea, board: other_board)
			UserVote.create(idea_id: other_idea.id, user: user)
			
			visit ideas_user_path(user)
			within('.user-stats') { click_link "Votes" }
			expect(current_path).to eq votes_user_path(user)
			expect(page).to have_content other_idea.title
		end

		scenario "view all user's boards from all user's ideas" do
			visit ideas_user_path(user)
			within('.user-stats') { click_link "Boards" }
			expect(current_path).to eq boards_user_path(user)
			expect(page).to have_content board.name
		end

		scenario "view all user's boards from all user's voted ideas" do
			visit votes_user_path(user)
			within('.user-stats') { click_link "Boards" }
			expect(current_path).to eq boards_user_path(user)
			expect(page).to have_content board.name
		end

		scenario "view all user's ideas from all user's voted ideas" do
			visit votes_user_path(user)
			within('.user-stats') { click_link "Ideas" }
			expect(current_path).to eq ideas_user_path(user)
			expect(page).to have_content user.display_name
		end

		scenario "view specific board from home page" do
			visit root_url
			click_link user.display_name
			click_link "#{board.name}"
			expect(current_path).to eq user_board_path(user, board)
			expect(page).to have_content board.name
			within('.group-header-stats') do
				expect(page).to have_content user.display_name
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
			click_link "#{user.display_name}"
			expect(current_path).to eq boards_user_path(user)
			expect(page).to have_content user.display_name
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