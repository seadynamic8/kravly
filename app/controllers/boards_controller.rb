class BoardsController < ApplicationController
	before_action :set_board, only: [:show, :update, :edit, :destroy]

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  private

  	def set_board
  		@board = Board.find(params[:id])
  	end
end
