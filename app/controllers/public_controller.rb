class PublicController < ApplicationController

  def index
  	if params[:recent].present?
  		@ideas = Idea.recent.page(params[:page]).per_page(9)
  	else
  		@ideas = Idea.popular.page(params[:page]).per_page(9)
  	end
  end

  def about
  end
end
