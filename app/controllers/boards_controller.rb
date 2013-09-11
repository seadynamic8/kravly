class BoardsController < ApplicationController
	before_action :set_board, only: [:show, :update, :edit, :destroy]
  skip_before_action :authorize, only: :show

  def show
    @ideas = @board.ideas.page(params[:page]).per_page(9)
    @user = @board.user

    if request.path != user_board_path(@user, @board)
      redirect_to user_board_path(@user, @board), status: :moved_permanently
    end
  end

  def new
    @board = Board.new(user_id: current_user.id)
    store_location
  end

  def create
    @board = Board.new(board_params)
    if @board.save
      redirect_to user_board_path(@board.user, @board), notice: "Board was created."
    else
      render :new
    end    
  end

  def edit
    store_location
  end

  def update
    if @board.update_attributes(board_params)
      redirect_to user_board_path(@board.user, @board), notice: "Board was updated."
    else
      render :edit
    end
  end

  def destroy
    @board.destroy
    redirect_to @board.user, notice: "Board was deleted."
  end

  private

  	def set_board
  		@board = Board.friendly.find(params[:id])
  	end

    def board_params
      params.require(:board).permit(:name, :description, :user_id)
    end
end
