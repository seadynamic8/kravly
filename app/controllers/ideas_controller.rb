class IdeasController < ApplicationController
	before_action :set_idea, only: [:show, :edit, :update, :destroy, :vote]

  def index
  end

  def show
    @user = @idea.user

    # The sidebar needs a board to pull up other ideas from (3 random ones).
    # So it chooses either the board it came from
    # Or chooses the first board (this is the path from home or from a vote or etc)
    board_id = params[:board]
    if board_id.nil?
      board = @idea.boards.first
    else
      board = Board.find(board_id)
    end
    
    @rand_ideas = []
    3.times do
      @rand_ideas << board.ideas.sample
    end
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def vote
    @idea.votes += 1
    @idea.save
    redirect_to @idea
  end

  private

  	def set_idea
  		@idea = Idea.find(params[:id])
  	end
end
