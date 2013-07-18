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
      assigns(:board).should eq board
    end

    it "renders the show template" do
      board = create(:board)
      get :show, id: board
      expect(response).to render_template :show
    end

    it "should have ideas inside the @board" do
      board = create(:board_with_ideas)
      get :show, id: board
      assigns(:board).ideas.count.should >= 0
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  # describe "GET 'edit'" do
  #   it "returns http success" do
  #     get 'edit'
  #     response.should be_success
  #   end
  # end

end
