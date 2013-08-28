class PublicController < ApplicationController

	skip_before_action :authorize

  def index
  	@most_popular_ideas = Idea.popular.limit(30)
  	#@most_recent_ideas = Idea.recent
  end
end
