class PublicController < ApplicationController

  def index
  	@ideas = Idea.popular.page(params[:page]).per_page(9)
  	#@most_recent_ideas = Idea.recent
  end

  def about
  end
end
