require 'spec_helper'

describe UsersController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "assigns the requested user to @user" do
      user = create(:user)
      get :show, id: user
      assigns(:user).should eq user
    end

    it "renders the :show template" do
      user = create(:user)
      get :show, id: user
      expect(response).to render_template :show
    end

    it "should have books inside the @user" do
      user = create(:user_with_books)
      get :show, id: user
      assigns(:user).books.count.should > 0
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
