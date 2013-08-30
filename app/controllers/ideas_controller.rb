class IdeasController < ApplicationController
	before_action :set_idea, only: [:show, :edit, :update, :destroy, :vote]
  skip_before_action :authorize, only: :show

  def show
    # The sidebar needs a board to pull up other ideas from (3 random ones).
    if @idea.board.ideas && @idea.board.ideas.count >= 3
      @rand_ideas = []
      3.times do
        @rand_ideas << @idea.board.ideas.sample
      end
    end
  end

  def new
    @idea = Idea.new
    @boards = current_user.boards
  end

  def create
    @idea = Idea.new(idea_params)
    if @idea.save
      redirect_to idea_path(@idea), notice: "Idea was created."
    else
      @boards = current_user.boards
      render :new
    end
  end

  def edit
    @boards = current_user.boards
  end

  def update
    if @idea.update_attributes(idea_params)
      redirect_to @idea, notice: "Idea was updated."
    else
      @boards = current_user.boards
      render :edit
    end
  end

  def destroy
    @idea.destroy
    redirect_to board_path(@idea.board), notice: "Idea was deleted."
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

    def idea_params
      params.require(:idea).permit(:title, :content, :votes, :image, :board_id)
    end
end
