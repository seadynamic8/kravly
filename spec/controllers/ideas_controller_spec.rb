require 'spec_helper'

describe IdeasController do

  let(:user) { create(:user) }
  before(:each) { login user }

  describe "GET 'show'" do
    let(:idea) { create(:idea) }

    it "assigns requested idea to @idea" do
      get :show, id: idea
      expect(assigns(:idea)).to eq idea
    end
    
    it "renders the show template" do
      get :show, id: idea
      expect(response).to render_template :show
    end

    # it "assigns 3 ideas from the same/similar board to @rand_ideas" do
    #   idea = create(:idea)
    #   get :show, id: idea
    #   expect(assigns(:rand_ideas)).to have(3).items
    # end
  end

  describe "GET 'new'" do
    let!(:board) { create(:board, user: user) }

    it "returns http success" do
      get :new
      expect(response).to be_success
    end

    it "assigns a new Idea to @idea" do
      get :new
      expect(assigns(:idea)).to be_a_new(Idea)
    end

    it "assigns current user's boards to @boards" do
      get :new
      expect(assigns(:boards)).to eq current_user.boards.newly_created
    end
  end

  describe "POST 'create'" do

    context "with valid attributes" do

      let(:board) { create(:board, user: user) }

      before(:each) do
        @attributes = attributes_for(:idea)
        @attributes[:board_id] = board.id
      end

      it "saves the new idea in the database" do

        expect {
          post :create, idea: @attributes
        }.to change(Idea, :count).by(1)
      end

      it "redirects to ideas#show" do
        post :create, idea: @attributes
        expect(response).to redirect_to idea_path(assigns(:idea))
      end
    end

    context "with in-valid attributes" do
      it "does not save the new idea in the database" do
        expect {
          post :create, idea: attributes_for(:invalid_idea)
        }.to_not change(Idea, :count).by(1)
      end

      it "assigns current user's boards to @boards" do
        post :create, idea: attributes_for(:invalid_idea)
        expect(assigns(:boards)).to eq current_user.boards.newly_created
      end

      it "re-renders the :new template" do
        post :create, idea: attributes_for(:invalid_idea)
        expect(response).to render_template :new
      end
    end
  end

  describe "GET 'edit'" do
    let(:board) { create(:board, user: user) }
    let(:idea) { create(:idea, board: board) }

    it "returns http success" do
      get :edit, id: idea
      expect(response).to be_success
    end

    it "assigns the requested idea to @idea" do
      get :edit, id: idea
      expect(assigns(:idea)).to eq idea
    end

    it "assigns current user's boards to @boards" do
      get :edit, id: idea
      expect(assigns(:boards)).to eq current_user.boards
    end

    it "renders the :edit template" do
      get :edit, id: idea
      expect(response).to render_template :edit
    end
  end

  describe "PATCH 'update'" do
    let(:board) { create(:board, user: user) }
    let(:idea) { create(:idea, board: board, title: "Test Idea") }

    context "valid attributes" do
      it "located the requested @idea" do
        patch :update, id: idea, idea: attributes_for(:idea)
        expect(assigns(:idea)).to eq(idea)
      end

      it "changes @idea attributes" do
        patch :update, id: idea, idea: attributes_for(:idea,
          title: "Different Idea")
        idea.reload
        expect(idea.title).to eq("Different Idea")
      end

      it "redirects to the updated idea" do
        patch :update, id: idea, idea: attributes_for(:idea)
        expect(response).to redirect_to assigns(:idea)
      end
    end

    context "invalid attributes" do
      it "does not change the idea's attributes" do
        patch :update, id: idea, idea: attributes_for(:idea,
          title: nil)
        idea.reload
        expect(idea.title).to eq("Test Idea")
      end

      it "assigns current user's boards to @boards" do
        patch :update, id: idea, idea: attributes_for(:invalid_idea)
        expect(assigns(:boards)).to eq current_user.boards
      end

      it "re-renders the edit template" do
        patch :update, id: idea, idea: attributes_for(:invalid_idea)
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE 'destroy'" do
    let(:board) { create(:board, user: user) }
    let(:idea) { create(:idea, board: board) }

    it "deletes the contact" do
      idea
      expect {
        delete :destroy, id: idea
      }.to change(Idea, :count).by(-1)
    end

    it "redirects to boards#show, board listing" do
      delete :destroy, id: idea
      expect(response).to redirect_to user_board_path(user, idea.board)
    end
  end

  describe "GET 'vote'" do
    let(:other_user) { create(:user) }
    let(:other_board) { create(:board, user: other_user) }
    let(:other_idea) { create(:idea, board: other_board) }

    it "assigns requested idea to @idea" do
      get :vote, id: other_idea
      expect(assigns(:idea)).to eq other_idea
    end

    it "increments the votes by 1" do
      orig_votes = other_idea.votes
      get :vote, id: other_idea
      other_idea.reload
      expect(other_idea.votes).to eq orig_votes + 1
    end

    it "doesn't increments the vote by 1 if already voted" do
      orig_votes = other_idea.votes
      UserVote.create(idea_id: other_idea.id, user: user)
      get :vote, id: other_idea
      other_idea.reload
      expect(other_idea.votes).to_not eq orig_votes + 1
    end

    it "has flash alert if already voted" do
      UserVote.create(idea_id: other_idea.id, user: user)
      get :vote, id: other_idea
      expect(flash[:alert]).to eq "Can't vote more than once."
    end

    it "redirect to show page" do
      get :vote, id: other_idea
      expect(response).to redirect_to assigns(:idea)
    end
  end
end
