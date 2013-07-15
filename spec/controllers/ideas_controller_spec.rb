require 'spec_helper'

describe IdeasController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "assigns requested idea to @idea" do
      idea = create(:idea)
      get :show, id: idea
      assigns(:idea).should eq idea
    end
    
    it "renders the show template" do
      idea = create(:idea)
      get :show, id: idea
      expect(response).to render_template :show
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
