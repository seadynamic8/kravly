require 'spec_helper'

describe BoardsController do

  let(:category) { create(:category) }
  let(:user) { create(:user) }
  before(:each) { login user }

  describe "GET 'show'" do

    let(:board) { create(:board, category: category, user: user) }

    it "returns http success" do
      get :show, user_id: user, id: board
      expect(response).to be_success
    end

    it "assigns the requested board to @board" do
      get :show, user_id: user, id: board
      expect(assigns(:board)).to eq board
    end

    # it "assigns the requested ideas to @ideas" do
    #   board = create(:board_with_ideas)
    #   get :show, id: board
    #   expect(assigns(:boards)).to eq board.ideas
    # end

    it "assigns the board's user to @user" do
      get :show, user_id: user, id: board
      expect(assigns(:user)).to eq board.user
    end

    it "renders the show template" do
      get :show, user_id: user, id: board
      expect(response).to render_template :show
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get :new, user_id: user
      expect(response).to be_success
    end

    it "assigns a new Board to @board" do
      get :new, user_id: user
      expect(assigns(:board)).to be_a_new(Board)
    end
  end

  describe "POST 'create'" do

    before(:each) do
      @attributes = attributes_for(:board)
      @attributes[:user_id] = user.id
      @attributes[:category_id] = category.id
    end

    context "with valid attributes" do
      it "saves the new board in the database" do
        expect {
          post :create, user_id: user, board: @attributes
        }.to change(Board, :count).by(1)
      end

      it "redirects to boards#show" do
        post :create, user_id: user, board: @attributes
        expect(response).to redirect_to user_board_path(assigns[:board].user, assigns[:board])
      end
    end

    context "with in-valid attributes" do
      it "does not save the new board in the database" do
        expect {
          post :create, user_id: user, board: attributes_for(:invalid_board)
        }.to_not change(Board, :count).by(1)
      end

      it "re-renders the :new template" do
        post :create, user_id: user, board: attributes_for(:invalid_board)
        expect(response).to render_template :new
      end
    end
  end

  describe "GET 'edit'" do

    let(:board) { create(:board, category: category, user: user) }

    it "returns http success" do
      get :edit, user_id: user, id: board
      expect(response).to be_success
    end

    it "assigns the requested board to @board" do
      get :edit, user_id: user, id: board
      expect(assigns(:board)).to eq board
    end

    it "renders the :edit template" do
      get :edit, user_id: user, id: board
      expect(response).to render_template :edit
    end
  end

  describe "PATCH 'update'" do

    let(:board) { create(:board, category: category, user: user, name: "Test Board") }

    context "valid attributes" do
      it "located the requested @board" do
        patch :update, user_id: user, id: board, board: attributes_for(:board)
        expect(assigns(:board)).to eq board
      end

      it "changes @board attributes" do
        patch :update, user_id: user, id: board, board: attributes_for(:board,
          name: "Different Board")
        board.reload
        expect(board.name).to eq("Different Board")
      end

      it "redirects to the updated board" do
        patch :update, user_id: user, id: board, board: attributes_for(:board)
        expect(response).to redirect_to user_board_path(assigns[:board].user, assigns[:board])
      end
    end

    context "invalid attributes" do
      it "does not change the board's attributes" do
        patch :update, user_id: user, id: board, board: attributes_for(:board,
          name: nil)
        board.reload
        expect(board.name).to eq("Test Board")
      end

      it "re-renders the edit template" do
        patch :update, user_id: user, id: board, board: attributes_for(:invalid_board)
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE 'destroy'" do
    
    let(:board) { create(:board, category: category, user: user) }

    it "deletes the board" do
      board
      expect {
        delete :destroy, user_id: user, id: board
      }.to change(Board, :count).by(-1)
    end

    it "redirects to users#boards listing" do
      delete :destroy, user_id: user, id: board
      expect(response).to redirect_to boards_user_path((assigns(:board)).user)
    end
  end
end
