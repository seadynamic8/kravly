require 'spec_helper'

feature "Guest Actions" do

	context "[user, board, idea]" do

		let(:user) { create(:user) }
		let(:board) { create(:board, user: user) }
		let!(:idea) { create(:idea, board: board) }

		scenario "go to discover page from home page" do
			visit root_url
			click_link "Discover"
			expect(current_path).to eq discover_path
		end

		scenario "Logo link from discover page goes to home page" do
			visit discover_path
			within('.top-bar') { click_link "Kravly" }
			expect(current_url).to eq root_url
		end

		scenario "view idea on discover page" do
			visit discover_path
			expect(page).to have_content idea.title
			expect(page).to have_content idea.votes
			expect(page).to have_content user.display_name
		end

		scenario "view specific idea from discover page" do
			visit discover_path
			click_link "#{idea.title}"
			expect(current_path).to eq idea_path(idea)
			expect(page).to have_content idea.title
			expect(page).to have_content idea.votes
			expect(page).to have_content user.display_name
			# expect(page).to have_content board.name
			# expect(page).to have_content "Contribution Level"
			expect(page).to have_content "Comments"
		end

		scenario "view all user's boards from discover page" do
			visit discover_path
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

		scenario "view specific board from discover page" do
			visit discover_path
			click_link user.display_name
			click_link "#{board.name}"
			expect(current_path).to eq user_board_path(user, board)
			expect(page).to have_content board.name
			within('.board-bar') do
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
			# click_link "#{board.name}"
			click_link "Back to Board"
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
			visit discover_path
			fill_in "query", with: "Cool Idea"
			click_button "Search"
			expect(current_path).to eq ideas_path
			expect(page).to have_content "Cool Idea"
		end

	end

end
