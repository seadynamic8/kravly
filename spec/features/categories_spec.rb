require 'spec_helper'

feature "Categories" do

	# let(:category) { create(:category, name: "Test Category") }

	# context "as a guest" do

	# 	scenario "See Categories on Discover Page" do
	# 		category
	# 		visit discover_path
	# 		within('.top-bar') { expect(page).to have_link "Categories" }
	# 		within('.top-bar .categories') { expect(page).to have_link "Test Category" }
	# 	end

	# 	scenario "See Popular and Recent Links under Categories on Discover Page" do
	# 		visit discover_path
	# 		within('.top-bar .categories') do
	# 			expect(page).to have_link "Popular"
	# 			expect(page).to have_link "Recent"
	# 		end
	# 	end

	# 	scenario "See Most Popular Ideas on Discover Page" do
	# 		idea1 = create(:idea, votes: 4)
	# 		idea2 = create(:idea, votes: 3)
	# 		visit discover_path
	# 		within('.top-bar') { click_link "Popular" }
	# 		expect(current_path).to eq discover_path
	# 		within(".main-ideas li:first-child .vote") { expect(page).to have_content "4" }
	# 		within(".main-ideas li:nth-child(2) .vote") { expect(page).to have_content "3" }
	# 	end

	# 	scenario "See Most Recent Ideas on Discover Page" do
	# 		idea1 = create(:idea, title: "Idea1")
	# 		idea2 = create(:idea, title: "Idea2")
	# 		visit discover_path
	# 		within('.top-bar') { click_link "Recent" }
	# 		expect(current_path).to eq discover_path #+ "?recent=true"
	# 		within(".main-ideas li:first-child") { expect(page).to have_content "Idea2" }
	# 		within(".main-ideas li:nth-child(2)") { expect(page).to have_content "Idea1" }
	# 	end

	# 	scenario "See only ideas from selected categories" do
	# 		other_category = create(:category)
	# 		board1 = create(:board, category: category)
	# 		board2 = create(:board, category: other_category)
	# 		create(:idea, title: "Idea1", board: board1)
	# 		create(:idea, title: "Idea2", board: board2)
	# 		visit discover_path
	# 		within('.top-bar') { click_link "Test Category" }
	# 		expect(current_path).to eq category_index_path(category)
	# 		within('.main-ideas') do
	# 			expect(page).to have_content "Idea1"
	# 			expect(page).to_not have_content "Idea2"
	# 		end
	# 	end

	# end

	# context "as an admin" do

	# 	before(:each) do
	# 		user = create(:user, admin: true)
	# 		log_in user
	# 	end

	# 	scenario "See All Categories in User Options Dropdown from Top Bar" do
	# 		visit discover_path
	# 		within('.top-bar') { expect(page).to have_link "All Categories" }
	# 	end

	# 	#To be done later, I haven't decided on Admin interface yet

	# end

end