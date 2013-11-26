class PublicController < ApplicationController

  def index
    if params[:category_id]
      category = Category.friendly.find(params[:category_id])
      boards = category.boards
      board_ids = boards.map { |b| b.id }
      @ideas = Idea.where(board_id: board_ids).page(params[:page]).per_page(9)
    elsif params[:recent]
      @ideas = Idea.recent.page(params[:page]).per_page(9)
    else
      @ideas = Idea.popular.page(params[:page]).per_page(9)
    end
  end

  def about
  end

  def intro  	
  end
end
