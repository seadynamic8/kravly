class BoardsController < ApplicationController
	before_action :current_resource, only: [:show, :edit, :update, :destroy]

  def index
    if params[:category_id]
      category = Category.friendly.find(params[:category_id])
      @boards = category.boards
    else
      @boards = Board.all
    end
  end

  def show
    @ideas = @board.ideas.page(params[:page]).per_page(20)
    @user = @board.user

    if request.path != user_board_path(@user, @board)
      redirect_to user_board_path(@user, @board), status: :moved_permanently
    end
  end

  def new
    @board = Board.new(user_id: current_user.id)
    @categories = Category.sorted
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
    redirect_to boards_user_path(@board.user), notice: "Board was deleted."
  end

  private

  	def current_resource
  		@board = Board.friendly.find(params[:id]) if params[:id]
  	end

    def board_params
      params.require(:board).permit(:name, :description, :user_id, :category_id)
    end
end
