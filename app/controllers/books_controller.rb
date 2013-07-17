class BooksController < ApplicationController
	before_action :set_book, only: [:show, :update, :edit, :destroy]

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  private

  	def set_book
  		@book = Book.find(params[:id])
  	end
end
