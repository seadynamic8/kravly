class IdeasController < ApplicationController
	before_action :set_idea, only: [:show, :edit, :update, :destroy, :vote]

  def index
  end

  def show
    board_id = params[:board]
    # this is done just in case it comes in from a vote (without a board) instead of a board.
    if board_id.nil?
      board = @idea.boards.first
    else
      board = Board.find(board_id)
    end
    @user = @idea.user
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
