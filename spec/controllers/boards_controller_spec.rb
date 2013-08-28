require 'spec_helper'

describe BoardsController do

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
    it "returns http success" do
      board = create(:board)
      get :show, id: board
      expect(response).to be_success
    end

    it "assigns the requested board to @board" do
      board = create(:board)
      get :show, id: board
      expect(assigns(:board)).to eq board
    end

    it "renders the show template" do
      board = create(:board)
      get :show, id: board
      expect(response).to render_template :show
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      expect(response).to be_success
    end

    it "assigns a new Board to @board" do
      get :new
      expect(assigns(:board)).to be_a_new(Board)
    end
  end

  describe "POST 'create'" do

    context "with valid attributes" do
      it "saves the new board in the database" do
        expect {
          post :create, board: attributes_for(:board)
        }.to change(Board, :count).by(1)
      end

      it "redirects to boards#show" do
        post :create, board: attributes_for(:board)
        expect(response).to redirect_to board_path(assigns[:board])
      end
    end

    context "with in-valid attributes" do
      it "does not save the new board in the database" do
        expect {
          post :create, board: attributes_for(:invalid_board)
        }.to_not change(Board, :count).by(1)
      end

      it "re-renders the :new template" do
        post :create, board: attributes_for(:invalid_board)
        expect(response).to render_template :new
      end
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      board = create(:board)
      get :edit, id: board
      expect(response).to be_success
    end

    it "assigns the requested board to @board" do
      board = create(:board)
      get :edit, id: board
      expect(assigns(:board)).to eq board
    end

    it "renders the :edit template" do
      board = create(:board)
      get :edit, id: board
      expect(response).to render_template :edit
    end
  end

  describe "PATCH 'update'" do
    before :each do
      @board = create(:board, name: "Test Board")
    end

    context "valid attributes" do
      it "located the requested @board" do
        patch :update, id: @board, board: attributes_for(:board)
        expect(assigns(:board)).to eq(@board)
      end

      it "changes @board attributes" do
        patch :update, id: @board, board: attributes_for(:board,
          name: "Different Board")
        @board.reload
        expect(@board.name).to eq("Different Board")
      end

      it "redirects to the updated board" do
        patch :update, id: @board, board: attributes_for(:board)
        expect(response).to redirect_to @board
      end
    end

    context "invalid attributes" do
      it "does not change the board's attributes" do
        patch :update, id: @board, board: attributes_for(:board,
          name: nil)
        @board.reload
        expect(@board.name).to eq("Test Board")
      end

      it "re-renders the edit template" do
        patch :update, id: @board, board: attributes_for(:invalid_board)
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE 'destroy'" do
    before :each do
      @board = create(:board)
    end

    it "deletes the contact" do
      expect {
        delete :destroy, id: @board
      }.to change(Board, :count).by(-1)
    end

    it "redirects to users#show, board listing" do
      delete :destroy, id: @board
      expect(response).to redirect_to user_path(@board.user)
    end
  end
end
