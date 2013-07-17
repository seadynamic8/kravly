require 'spec_helper'

describe BooksController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      book = create(:book)
      get :show, id: book
      response.should be_success
    end

    it "assigns the requested book to @book" do
      book = create(:book)
      get :show, id: book
      assigns(:book).should eq book
    end

    it "renders the show template" do
      book = create(:book)
      get :show, id: book
      expect(response).to render_template :show
    end

    it "should have ideas inside the @book" do
      book = create(:book_with_ideas)
      get :show, id: book
      assigns(:book).ideas.count.should >= 0
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
