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
      idea = create(:idea_with_boards)
      get :show, id: idea
      assigns(:idea).should eq idea
    end
    
    it "renders the show template" do
      idea = create(:idea_with_boards)
      get :show, id: idea
      expect(response).to render_template :show
    end

    it "should belong to boards inside @idea" do
      idea = create(:idea_with_boards)
      get :show, id: idea
      assigns(:idea).boards.count.should >= 0
    end

    it "assigns 3 ideas from the same/similar board to @rand_ideas" do
      idea = create(:idea_with_boards)
      get :show, id: idea
      ideas = idea.boards.first.ideas
      assigns(:rand_ideas).should have(3).items
      #ideas.should include(assigns(:rand_ideas).join(','))
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

  describe "GET 'vote'" do
    it "assigns requested idea to @idea" do
      idea = create(:idea_with_boards)
      get :vote, id: idea
      assigns(:idea).should eq idea
    end

    # it "increments the votes by 1" do
    #   idea = create(:idea_with_boards)
    #   orig_votes = idea.votes

    #   #idea.votes.should eq (orig_votes + 1)
    #   #expect { get :vote, id: idea }.to change { idea, :votes }.by(1) 
    # end

    it "redirect to show page" do
      idea = create(:idea_with_boards)
      get :vote, id: idea
      expect(response).to redirect_to idea
    end
  end
end
