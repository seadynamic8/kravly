require 'spec_helper'

describe PublicController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end

    # it "assigns all the ideas to @ideas" do
    # 	ideas = Idea.all
    # 	get 'index'
    	
    # end
  end

end
