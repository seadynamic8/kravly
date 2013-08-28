require 'spec_helper'

describe BoardsController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      board = create(:board)
      get :show, id: board
      response.should be_success
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
      response.should be_success
    end

    it "assigns a new Board to @board" do
      get :new
      expect(assigns(:board)).to be_a_new(Board)
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      board = create(:board)
      get :edit, id: board
      response.should be_success
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

  describe "POST 'create'" do

    context "with valid attributes" do
      it "saves the new contact in the database" do
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
      it "does not save the new contact in the database" do
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

end
