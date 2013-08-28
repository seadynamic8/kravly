class BoardsController < ApplicationController
	before_action :set_board, only: [:show, :update, :edit, :destroy]
  skip_before_action :authorize, only: :show

  def index
  end

  def show
  end

  def new
    @board = Board.new
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

  private

  	def set_board
  		@board = Board.find(params[:id])
  	end

    def board_params
      params.require(:board).permit(:name)
    end
end
