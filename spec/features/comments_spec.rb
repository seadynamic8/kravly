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

		# scenario "cannot edit comment" do
		# 	user = create(:user)
		# 	(comment = Comment.build_from(idea, user.id, "")).save
		# 	visit edit_comment_path(comment.commentable_id)
		# 	expect(page).to have_content "Please login."
		# end

		scenario "should see a message for 'no comments yet' if there are no comments" do
			visit idea_path(idea)
			expect(page).to have_css "div.empty-comments"
			expect(page).to have_content "There are no comments yet."
		end

		# scenario "cannot reply to comment" do
		# 	user = create(:user)
		# 	(comment = Comment.build_from(idea, user.id, "")).save
		# 	visit reply_comment_path(idea.id, comment.commentable_id)
		# 	expect(page).to have_content "Please login"
		# end

	end

	context "as a member" do

		let(:user) { create(:user) }
		let(:board) { create(:board, user: user) }
		let(:idea) { create(:idea, board: board) }
		before(:each) { log_in user }

		scenario "can not see Delete button" do
			visit idea_path(idea)
			fill_in "comment[body]", with: "New Comment Text"
			click_button "Comment"
			within('div.comment') do
				expect(page).to_not have_css "i.fi-x"
			end
		end

		context "Creating" do

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
					expect(page).to have_css "i.fi-page-edit"
					expect(page).to have_css ".comment-user img" # comment avatar img
					expect(page).to have_content user.display_name
					expect(page).to have_content "New Comment Text"
					expect(page).to have_link "reply"
					expect(page).to have_css "span.time"
				end
			end
		end

		context "Editing" do

			scenario "can not see other's comments Edit link" do
				other_user = create(:user)
				Comment.build_from(idea, other_user.id, "Other Comment").save
				visit idea_path(idea)
				within('div.comment') do
					expect(page).to_not have_css "i.fi-page-edit"
				end
			end

			scenario "can see your own comment's Edit link" do
				Comment.build_from(idea, user.id, "New Comment").save
				visit idea_path(idea)
				within('div.comment') do
					expect(page).to have_css "i.fi-page-edit"
				end
			end

			scenario "can see Cancel link, when Edit is clicked", js: true do
				Comment.build_from(idea, user.id, "New Comment").save
				visit idea_path(idea)

				within('.comments') { find('.edit-link').trigger('click') }
				within('div.comment') do
					expect(page).to have_link "Cancel"
				end
				within('.comment-edit-form') do
					expect(page).to have_css "textarea"
					expect(page).to have_button "Update Comment"
				end
			end

			scenario "can Edit comment", js:true do
				Comment.build_from(idea, user.id, "New Comment").save
				visit idea_path(idea)

				within('.comments') { find('i.fi-page-edit').trigger('click') }
				within('.comment-edit-form') do
					fill_in "comment[body]", with: "Updated Comment"
					click_button "Update Comment"
				end
				within('.comment') do
					expect(page).to have_content "Updated Comment"
				end
			end

			scenario "can Edit child comment", js: true do
				(parent_comment = Comment.build_from(idea, user.id, "New Comment")).save
				(child_comment = Comment.build_from(idea, user.id, "Child Comment")).save
				child_comment.move_to_child_of(parent_comment)
				visit idea_path(idea)

				within('.child-comments') do
					find('.edit-link').trigger('click')
					within('.comment-edit-form') do
						fill_in "comment[body]", with: "Updated Comment"
						click_button "Update Comment"
					end
				end
				within('.child-comments') do
					expect(page).to have_content "Updated Comment"
				end
			end
		end

		context "Replying" do

			scenario "can see Reply link" do
				other_user = create(:user)
				Comment.build_from(idea, other_user.id, "Other Comment").save
				visit idea_path(idea)
				within('div.comments') { expect(page).to have_link "reply" }
				# expect(page).to have_css "div.reply-form"
			end

			scenario "can see Hide link and Reply Form when reply is clicked", js: true do
				other_user = create(:user)
				Comment.build_from(idea, other_user.id, "Other Comment").save

				visit idea_path(idea)
				click_link "reply"

				within('div.comment') { expect(page).to have_link "hide" }
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
				click_link "reply"
				click_link "hide"

				within('div.comment') { expect(page).to have_link "reply" }
			end

			scenario "can Reply to root comment", js: true do
				other_user = create(:user)
				Comment.build_from(idea, other_user.id, "Other Comment").save

				visit idea_path(idea)
				click_link "reply"
				within('.reply-form') do
					fill_in "comment[body]", with: "New Comment Text"
				end
				click_button "Reply"

				expect(page).to have_css('div.child-comments')
				within('div.child-comments') do
					expect(page).to have_css "i.fi-page-edit"
					expect(page).to have_css ".comment-user img" # comment avatar img
					expect(page).to have_content user.display_name
					expect(page).to have_content "New Comment Text"
					expect(page).to have_link "reply"
					expect(page).to have_css "span.time"
				end
			end

			scenario "can Reply to root comment with a child comment existing", js: true do
				other_user = create(:user)
				(parent_comment = Comment.build_from(idea, other_user.id, "Other Comment")).save
				(child_comment = Comment.build_from(idea, other_user.id, "Child Comment")).save
				child_comment.move_to_child_of(parent_comment)

				visit idea_path(idea)
				within("#comment-#{parent_comment.id}") { find(".reply-link").click }
				within("#reply-form-#{parent_comment.id}") do
					fill_in "comment[body]", with: "New Comment Text"
					click_button "Reply"
				end

				within('div.child-comments') do
					expect(page).to have_content "Child Comment"
					expect(page).to have_content "New Comment Text"
				end
			end

			scenario "can Reply to child comment", js: true do
				other_user = create(:user)
				(parent_comment = Comment.build_from(idea, other_user.id, "Other Comment")).save
				(child_comment = Comment.build_from(idea, other_user.id, "Child Comment")).save
				child_comment.move_to_child_of(parent_comment)

				visit idea_path(idea)
				within('.child-comments') do
					click_link "reply"
					within("#reply-form-#{child_comment.id}") do
						fill_in "comment[body]", with: "New Comment Text"
						click_button "Reply"
					end
				end

				within('.child-comments') do
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
				expect(page).to have_css "i.fi-x"
			end
		end

		scenario "can see own Delete button" do
			visit idea_path(idea)
			fill_in "comment[body]", with: "New Comment Text"
			click_button "Comment"
			within('div.comment') do
				expect(page).to have_css "i.fi-x"
			end
		end

		scenario "can delete root Comment" do
			Comment.build_from(idea, user.id, "New Comment Text").save
			visit idea_path(idea)
			expect {
				find('.comment .delete-link').click
			}.to change(Comment, :count).by(-1)
			expect(page).to_not have_content "New Comment Text"
			expect(page).to have_css ".empty-comments"
		end

		scenario "can delete child Comment" do
			(parent_comment = Comment.build_from(idea, user.id, "New Comment")).save
			(child_comment = Comment.build_from(idea, user.id, "Child Comment")).save
			child_comment.move_to_child_of(parent_comment)
			visit idea_path(idea)
			within('.child-comments') do
				find('.comment .delete-link').click
			end
			expect(page).to have_content "New Comment"
			expect(page).to_not have_content "Child Comment"
		end
	end

end