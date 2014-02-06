class PublicController < ApplicationController

  def index
    @user = User.new
    render layout: "home"
  end

  def discover
    if params[:category_id]
      category = Category.friendly.find(params[:category_id])
      boards = category.boards
      board_ids = boards.map { |b| b.id }
      @ideas = Idea.where(board_id: board_ids).page(params[:page]).per_page(20)
    elsif params[:recent]
      @ideas = Idea.recent.page(params[:page]).per_page(20)
    else
      @ideas = Idea.popular.page(params[:page]).per_page(20)
    end
  end

  def about
  end

  def intro  	
  end

  def basics
  end

  def terms
  end

  def privacy
  end
end
