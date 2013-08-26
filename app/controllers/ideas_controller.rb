class IdeasController < ApplicationController
	before_action :set_idea, only: [:show, :edit, :update, :destroy, :vote]

  def index
  end

  def show
    @user = @idea.user

    # The sidebar needs a board to pull up other ideas from (3 random ones).
    @rand_ideas = []
    3.times do
      @rand_ideas << @idea.board.ideas.sample
    end
  end

  def new
    @idea = Idea.new
    @boards = Board.all  #need to update this to @current_user.boards
  end

  def create
  end

  def edit
    @boards = @idea.board.user.boards #need to update this to @current_user.boards
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
