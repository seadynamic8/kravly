require 'spec_helper'

describe PublicController do

  describe "GET 'index'" do
    it "returns http success" do
      get :index
      response.should be_success
    end
  end

  describe "GET 'discover'" do
    it "assigns all the popular ideas to @ideas" do
    	ideas = Idea.popular.first(12)
    	get :discover
    	expect(assigns(:ideas)).to eq ideas
    end

    it "assigns all the recent ideas to @ideas if params[:recent] is set" do
      ideas = Idea.recent.first(12)
      get :discover, recent: true
      expect(assigns(:ideas)).to eq ideas
    end
  end

end
