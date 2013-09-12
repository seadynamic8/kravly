require 'spec_helper'

RSpec::Matchers.define :permit do |*args|
	match do |permission|
		expect(permission.permit?(*args)).to be_true
	end
end

describe Permission do

	describe "as guest" do

		subject { Permission.new(nil) }

		it { should permit("public", "index") }

		it "allows sessions" do
			should permit("sessions", "new")
			should permit("sessions", "create")
			should permit("sessions", "destroy")
		end

		it "allows password_resets" do
			should permit("password_resets", "new")
			should permit("password_resets", "create")
			should permit("password_resets", "edit")
			should permit("password_resets", "update")
		end

		it "allows users" do
			should permit("users", "new")
			should permit("users", "create")
			should permit("users", "boards")
			should permit("users", "ideas")
			should_not permit("users", "edit")
			should_not permit("users", "update")
			should_not permit("users", "destroy")
			should_not permit("users", "settings")
		end

		it "allows boards" do
			should permit("boards", "show")
			should_not permit("boards", "new")
			should_not permit("boards", "create")
			should_not permit("boards", "edit")
			should_not permit("boards", "update")
			should_not permit("boards", "destroy")
		end

		it "allows ideas" do
			should permit("ideas", "index")
			should permit("ideas", "show")
			should_not permit("ideas", "new")
			should_not permit("ideas", "create")
			should_not permit("ideas", "edit")
			should_not permit("ideas", "update")
			should_not permit("ideas", "destroy")
			should_not permit("ideas", "vote")
		end

		it "allows comments" do
			should_not permit("comments", "create")
			should_not permit("comments", "edit")
			should_not permit("comments", "update")
			should_not permit("comments", "destroy")
		end
	end

	describe "as member" do

		let(:user) { create(:user) }
		let(:user_board) { create(:board, user: user) }
		let(:user_idea) { create(:idea, board: user_board) }
		let(:user_comment) { Comment.build_from(user_idea, user.id, "") }

		let(:other_user) { build(:user) }
		let(:other_board) { build(:board) }
		let(:other_idea) { build(:idea) }
		let(:other_comment) { Comment.build_from(build(:idea), build(:user), "") }

		subject { Permission.new(user) }

		it { should permit("public", "index") }

		it "allows sessions" do
			should permit("sessions", "new")
			should permit("sessions", "create")
			should permit("sessions", "destroy")
		end

		it "allows password_resets" do
			should permit("password_resets", "new")
			should permit("password_resets", "create")
			should permit("password_resets", "edit")
			should permit("password_resets", "update")
		end

		it "allows users" do
			should permit("users", "new")
			should permit("users", "create")
			should permit("users", "boards")
			should permit("users", "ideas")
			should permit("users", "edit", user)
			should_not permit("users", "edit", other_user)
			should permit("users", "update", user)
			should_not permit("users", "update", other_user)
			should permit("users", "destroy", user)
			should_not permit("users", "destroy", other_user)
			should permit("users", "settings", user)
			should_not permit("users", "settings", other_user)
		end

		it "allows boards" do
			should permit("boards", "show")
			should permit("boards", "new")
			should permit("boards", "create")
			should permit("boards", "edit", user_board)
			should_not permit("boards", "edit", other_board)
			should permit("boards", "update", user_board)
			should_not permit("boards", "update", other_board)
			should permit("boards", "destroy", user_board)
			should_not permit("boards", "destroy", other_board)
		end

		it "allows ideas" do
			should permit("ideas", "index")
			should permit("ideas", "show")
			should permit("ideas", "new")
			should permit("ideas", "create")
			should permit("ideas", "edit", user_idea )
			should_not permit("ideas", "edit", other_idea)
			should permit("ideas", "update", user_idea )
			should_not permit("ideas", "update", other_idea)
			should permit("ideas", "destroy", user_idea )
			should_not permit("ideas", "destroy", other_idea)
			should_not permit("ideas", "vote", user_idea)
			should permit("ideas", "vote", other_idea)
		end

		it "allows comments" do
			should permit("comments", "create")
			should permit("comments", "edit", user_comment)
			should_not permit("comments", "edit", other_comment)
			should permit("comments", "update", user_comment)
			should_not permit("comments", "update", other_comment)
			should_not permit("comments", "destroy")
		end
	end

	describe "as admin" do
		subject { Permission.new(build(:user, admin: true)) }
		it { should permit("anything", "here") }
	end
end