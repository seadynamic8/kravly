class BoardsController < ApplicationController
	before_action :set_board, only: [:show, :update, :edit, :destroy]
  skip_before_action :authorize, only: :show

  def show
  end

  def new
    @board = Board.new(user_id: current_user.id)
  end

  def create
    @board = Board.new(board_params)
    if @board.save
      redirect_to board_path(@board), notice: "Board was created."
    else
      render :new
    end    
  end

  def edit
  end

  def update
    if @board.update_attributes(board_params)
      redirect_to @board, notice: "Board was updated."
    else
      render :edit
    end
  end

  def destroy
    @board.destroy
    redirect_to user_path(@board.user), notice: "Board was deleted."
  end

  private

  	def set_board
  		@board = Board.find(params[:id])
  	end

    def board_params
      params.require(:board).permit(:name, :description, :user_id)
    end
end
