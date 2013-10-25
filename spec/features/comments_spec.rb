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

		scenario "cannot reply to comment" do
			user = create(:user)
			comment = Comment.build_from(idea, user.id, "")
			visit reply_comment_path(idea.id, comment.commentable_id)
			expect(page).to have_content "Please login"
		end

	end

	context "as a member" do

		let(:user) { create(:user) }
		let(:board) { create(:board, user: user) }
		let(:idea) { create(:idea, board: board) }
		before(:each) { log_in user }

		scenario "can see comment input form" do
			visit idea_path(idea)
			within('.comment-form') do
				expect(page).to have_css "img.comment-avatar"
				expect(page).to have_css "textarea.comment-body"
				expect(page).to have_button "Comment"
			end
		end

		scenario "can comment successfully" do
			visit idea_path(idea)
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

		context "Editing" do

			scenario "can not see other's comments Edit link" do
				other_user = create(:user)
				Comment.build_from(idea, other_user.id, "Other Comment").save
				visit idea_path(idea)
				within('div.comment') do
					expect(page).to_not have_link "Edit"
				end
			end

			scenario "can see your own comment's Edit link" do
				Comment.build_from(idea, user.id, "New Comment").save
				visit idea_path(idea)
				within('div.comment') do
					expect(page).to have_link "Edit"
				end
			end

			scenario "can see Cancel link, when Edit is clicked", js: true, focus: true do
				Comment.build_from(idea, user.id, "New Comment").save
				visit idea_path(idea)
				click_link "Edit"
				within('div.comments') do
					expect(page).to have_link "Cancel"
				end
				within('.edit-comment-form') do
					expect(page).to have_button "Update Comment"
				end
			end

		end

		scenario "can not see Delete button" do
			visit idea_path(idea)
			fill_in "comment[body]", with: "New Comment Text"
			click_button "Comment"
			within('div.comment') do
				expect(page).to_not have_link "x"
			end
		end

		context "Replying" do

			scenario "can see Reply link" do
				other_user = create(:user)
				Comment.build_from(idea, other_user.id, "Other Comment").save
				visit idea_path(idea)
				within('div.comments') { expect(page).to have_link "Reply" }
				# expect(page).to have_css "div.reply-form"
			end

			scenario "can see Hide link and Reply Form when reply is clicked", js: true do
				other_user = create(:user)
				Comment.build_from(idea, other_user.id, "Other Comment").save

				visit idea_path(idea)
				click_link "Reply"

				within('div.comment') { expect(page).to have_link "Hide" }
				within('.reply-form') do
					expect(page).to have_css "img.comment-avatar"
					expect(page).to have_css "textarea.comment-body"
					expect(page).to have_button "Reply"
				end
			end

			scenario "see Reply link after clicking Hide", js: true do
				other_user = create(:user)
				Comment.build_from(idea, other_user.id, "Other Comment").save

				visit idea_path(idea)
				click_link "Reply"
				click_link "Hide"

				within('div.comment') { expect(page).to have_link "Reply" }
			end

			scenario "can Reply to root comment", js: true do
				other_user = create(:user)
				Comment.build_from(idea, other_user.id, "Other Comment").save

				visit idea_path(idea)
				click_link "Reply"
				within('.reply-form') do
					fill_in "comment[body]", with: "New Comment Text"
				end
				click_button "Reply"

				expect(page).to have_css('div.child-comments')
				within('div.child-comment') do
					expect(page).to have_link "Edit"
					expect(page).to have_css "img.comment-avatar"
					expect(page).to have_content user.display_name
					expect(page).to have_content "New Comment Text"
					expect(page).to have_link "Reply"
					expect(page).to have_css "span.time"
				end
			end

			scenario "can Reply to root comment with a child comment existing", js: true do
				other_user = create(:user)
				parent_comment = Comment.build_from(idea, other_user.id, "Other Comment")
				parent_comment.save
				child_comment = Comment.build_from(idea, other_user.id, "Child Comment")
				child_comment.save
				child_comment.move_to_child_of(parent_comment)

				visit idea_path(idea)
				find("#reply-#{parent_comment.id}").click
				within("#reply-form-#{parent_comment.id}") do
					fill_in "comment[body]", with: "New Comment Text"
					click_button "Reply"
				end

				within('div.child-comments') do
					expect(page).to have_content "Child Comment"
					expect(page).to have_content "New Comment Text"
				end
			end
		end

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