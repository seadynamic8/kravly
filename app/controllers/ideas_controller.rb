class IdeasController < ApplicationController
	before_action :set_idea, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
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

  private

  	def set_idea
  		@idea = Idea.find(params[:id])
  	end
end
