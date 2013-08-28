require 'spec_helper'

describe IdeasController do

  before :each do
    user = create(:user)
    login user
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      expect(response).to be_success
    end
  end

  describe "GET 'show'" do
    it "assigns requested idea to @idea" do
      idea = create(:idea)
      get :show, id: idea
      expect(assigns(:idea)).to eq idea
    end
    
    it "renders the show template" do
      idea = create(:idea)
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
    it "returns http success" do
      get 'new'
      expect(response).to be_success
    end

    it "assigns a new Idea to @idea" do
      get 'new'
      expect(assigns(:idea)).to be_a_new(Idea)
    end

    it "assigns current user's boards to @boards" do
      get 'new'
      expect(assigns(:boards)).to eq current_user.boards
    end
  end

  describe "POST 'create'" do

    context "with valid attributes" do
      it "saves the new idea in the database" do
        expect {
          post :create, idea: attributes_for(:idea)
        }.to change(Idea, :count).by(1)
      end

      it "redirects to ideas#show" do
        post :create, idea: attributes_for(:idea)
        expect(response).to redirect_to idea_path(assigns[:idea])
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
        expect(assigns(:boards)).to eq current_user.boards
      end

      it "re-renders the :new template" do
        post :create, idea: attributes_for(:invalid_idea)
        expect(response).to render_template :new
      end
    end
  end

  describe "GET 'edit'" do
    before :each do
      @idea = create(:idea)
    end

    it "returns http success" do
      get :edit, id: @idea
      expect(response).to be_success
    end

    it "assigns the requested idea to @idea" do
      get :edit, id: @idea
      expect(assigns(:idea)).to eq @idea
    end

    it "assigns current user's boards to @boards" do
      get :edit, id: @idea
      expect(assigns(:boards)).to eq current_user.boards
    end

    it "renders the :edit template" do
      get :edit, id: @idea
      expect(response).to render_template :edit
    end
  end

  describe "PATCH 'update'" do
    before :each do
      @idea = create(:idea, title: "Test Idea")
    end

    context "valid attributes" do
      it "located the requested @idea" do
        patch :update, id: @idea, idea: attributes_for(:idea)
        expect(assigns(:idea)).to eq(@idea)
      end

      it "changes @idea attributes" do
        patch :update, id: @idea, idea: attributes_for(:idea,
          title: "Different Idea")
        @idea.reload
        expect(@idea.title).to eq("Different Idea")
      end

      it "redirects to the updated idea" do
        patch :update, id: @idea, idea: attributes_for(:idea)
        expect(response).to redirect_to @idea
      end
    end

    context "invalid attributes" do
      it "does not change the idea's attributes" do
        patch :update, id: @idea, idea: attributes_for(:idea,
          title: nil)
        @idea.reload
        expect(@idea.title).to eq("Test Idea")
      end

      it "assigns current user's boards to @boards" do
        patch :update, id: @idea, idea: attributes_for(:invalid_idea)
        expect(assigns(:boards)).to eq current_user.boards
      end

      it "re-renders the edit template" do
        patch :update, id: @idea, idea: attributes_for(:invalid_idea)
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE 'destroy'" do
    before :each do
      @idea = create(:idea)
    end

    it "deletes the contact" do
      expect {
        delete :destroy, id: @idea
      }.to change(Idea, :count).by(-1)
    end

    it "redirects to users#show, idea listing" do
      delete :destroy, id: @idea
      expect(response).to redirect_to board_path(@idea.board)
    end
  end

  describe "GET 'vote'" do
    it "assigns requested idea to @idea" do
      idea = create(:idea)
      get :vote, id: idea
      expect(assigns(:idea)).to eq idea
    end

    # it "increments the votes by 1" do
    #   idea = create(:idea)
    #   orig_votes = idea.votes
    #   get :vote, id: idea
    #   idea.votes.should eq (orig_votes + 1)
    #   #expect { get :vote, id: idea }.to change(idea, :votes).by(1) 
    # end

    it "redirect to show page" do
      idea = create(:idea)
      get :vote, id: idea
      expect(response).to redirect_to idea
    end
  end
end
