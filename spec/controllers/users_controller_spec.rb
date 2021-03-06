require 'spec_helper'

describe UsersController do

  describe "GET 'new'" do
    it "returns http success" do
      get :new
      expect(response).to be_success
    end

    it "assigns a new user to @user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "POST 'create'" do

    context "with valid attributes" do
      it "saves the new user in the database" do
        expect {
          post :create, user: attributes_for(:user)
        }.to change(User, :count).by(1)
      end

      # it "logs the user in using the session variable :user_id" do
      #   user = create(:user)
      #   post :create, user: attributes_for(:user)
      #   expect(assigns(session[:user_id])).to eq user.id
      # end

      it "redirects to user boards page" do 
        post :create, user: attributes_for(:user)
        expect(response).to redirect_to boards_user_path(assigns[:user])
      end
    end

    context "with in-valid attributes" do
      it "does not save the new user in the database" do
        expect {
          post :create, user: attributes_for(:invalid_user)
        }.to_not change(User, :count).by(1)
      end

      it "re-renders the :new template" do
        post :create, user: attributes_for(:invalid_user)
        expect(response).to render_template :new
      end
    end
  end

  describe "GET 'edit'" do

    let(:user) { create(:user) }
    before(:each) { login user }

    it "returns http success" do
      get :edit, id: user
      expect(response).to be_success
    end

    it "assigns the requested user to @user" do
      get :edit, id: user
      expect(assigns(:user)).to eq user
    end

    it "renders the :edit template" do
      get :edit, id: user
      expect(response).to render_template :edit
    end
  end

  describe "PATCH 'update'" do

    let(:user) { create(:user, email: "test@example.com") }
    before(:each) { login user }

    context "valid attributes" do
      it "located the requested @user" do
        patch :update, id: user, user: attributes_for(:user)
        expect(assigns(:user)).to eq(user)
      end

      it "changes @user attributes" do
        patch :update, id: user, user: attributes_for(:user,
          email: "different@example.com")
        user.reload
        expect(user.email).to eq("different@example.com")
      end

      it "redirects to the updated user's boards page" do
        patch :update, id: user, user: attributes_for(:user)
        expect(response).to redirect_to boards_user_path(assigns[:user])
      end
    end

    context "invalid attributes" do
      it "does not change the user's attributes" do
        patch :update, id: user, user: attributes_for(:user,
          email: nil)
        user.reload
        expect(user.email).to eq("test@example.com")
      end

      it "re-renders the edit template" do
        patch :update, id: user, user: attributes_for(:invalid_user)
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE 'destroy'" do

    let(:user) { create(:user) }
    before(:each) { login user }

    it "deletes the contact" do
      expect {
        delete :destroy, id: user
      }.to change(User, :count).by(-1)
    end

    # it "logs the user out by setting the session variable :user_id to nil" do
    #   user = create(:user)
    #   post :create, user: attributes_for(:user)
    #   expect(assigns(session[:user_id])).to eq nil
    # end

    it "redirects to root_url" do
      delete :destroy, id: user
      expect(response).to redirect_to root_url
    end
  end

  describe "GET 'settings'" do

    let(:user) { create(:user) }
    before(:each) { login user }

    it "returns http success" do
      get :settings, id: user
      expect(response).to be_success
    end

    it "assigns the requested user to @user" do
      get :settings, id: user
      expect(assigns(:user)).to eq user
    end

    it "renders the :settings template" do
      get :settings, id: user
      expect(response).to render_template :settings
    end
  end

  describe "GET 'boards'" do

    let(:user) { create(:user) }

    it "assigns the requested user to @user" do
      get :boards, id: user
      expect(assigns(:user)).to eq user
    end

    # it "assigns the requested boards to @boards" do
    #   user = create(:user_with_boards)
    #   get :show, id: user
    #   expect(assigns(:boards)).to eq user.boards
    # end

    it "renders the :boards template" do
      get :boards, id: user
      expect(response).to render_template :boards
    end
  end

  describe "GET 'ideas'" do
    
    let(:user) { create(:user) }

    it "returns http success" do
      get :ideas, id: user
      expect(response).to be_success
    end

    it "assigns the requested user to @user" do
      get :ideas, id: user
      expect(assigns(:user)).to eq user
    end

    # it "assigns the requested ideas to @ideas" do
    # end

    it "renders the :ideas template" do
      get :ideas, id: user
      expect(response).to render_template :ideas
    end
  end

  describe "GET 'votes'" do
    
    let(:user) { create(:user) }

    it "returns http success" do
      get :votes, id: user
      expect(response).to be_success
    end

    it "assigns the requested user to @user" do
      get :votes, id: user
      expect(assigns(:user)).to eq user
    end

    # it "assigns the requested votes to @votes" do
    # end

    it "renders the :votes template" do
      get :votes, id: user
      expect(response).to render_template :votes
    end
  end
end
