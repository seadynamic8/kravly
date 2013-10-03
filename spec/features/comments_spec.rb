require 'spec_helper'

feature "Comments Management" do

	context "as a guest" do

		let(:idea) { create(:idea) }

		scenario "can only login or signup" do
			visit idea_path(idea)
			within('.comments') do
				expect(page).to have_link "Login"
				expect(page).to have_link "Signup"
			end
		end

		scenario "cannot edit comment" do
			user = create(:user)
			comment = Comment.build_from(idea, user.id, "")
			visit edit_comment_path(comment.commentable_id)
			expect(page).to have_content "Please login."
		end

		scenario "should see a message for 'no comments yet' if there are no comments" do
			visit idea_path(idea)
			expect(page).to have_css "div.empty-comments"
			expect(page).to have_content "There are no comments yet."
		end

	end

	context "as a member" do

		let(:user) { create(:user) }
		let(:board) { create(:board, user: user) }
		let(:idea) { create(:idea, board: board) }
		before(:each) do
			log_in user
			visit idea_path(idea)
		end

		scenario "can see comment input form" do
			within('.comment-form') do
				expect(page).to have_css "img.comment-avatar"
				expect(page).to have_css "textarea.comment-body"
				expect(page).to have_button "Comment"
			end
		end

		scenario "can comment successfully" do
			expect {
				fill_in "comment[body]", with: "New Comment Text"
				click_button "Comment"
			}.to change(Comment, :count).by(1)
			within('div.comment') do
				expect(page).to have_link "Edit"
				expect(page).to have_css "img.comment-avatar"
				expect(page).to have_content user.display_name
				expect(page).to have_content "New Comment Text"
				# expect(page).to have_link "Reply"
				expect(page).to have_css "span.time"
			end
		end

		scenario "can not see other's comments Edit button" do
			other_user = create(:user)
			Comment.build_from(idea, other_user.id, "Other Comment").save
			visit idea_path(idea)
			within('div.comment') do
				expect(page).to_not have_link "Edit"
			end
		end

		scenario "can not see Delete button" do
			fill_in "comment[body]", with: "New Comment Text"
			click_button "Comment"
			within('div.comment') do
				expect(page).to_not have_link "x"
			end
		end

		# scenario "can reply to comment" do
		# 	other_user = create(:user)
		# 	Comment.build_from(idea, other_user.id, "Other Comment").save
		# 	visit idea_path(idea)
		# 	click_button "Reply"
		# 	expect(page).to have_button "Reply"
		# 	expect(page).to have_css "div.reply-form"
		# end

	end

	context "as an admin" do

		let(:user) { create(:user, admin: true) }
		let(:board) { create(:board, user: user) }
		let(:idea) { create(:idea, board: board) }
		before(:each) { log_in user }

		scenario "can see other's Delete button" do
			other_user = create(:user)
			Comment.build_from(idea, other_user.id, "Other Comment").save
			visit idea_path(idea)
			within('div.comment') do
				expect(page).to have_link "x"
			end
		end

		scenario "can see own Delete button" do
			visit idea_path(idea)
			fill_in "comment[body]", with: "New Comment Text"
			click_button "Comment"
			within('div.comment') do
				expect(page).to have_link "x"
			end
		end

	end

end