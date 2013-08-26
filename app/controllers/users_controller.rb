class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy, :settings]

  def index
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def settings
  end

  private

  	def set_user
  		@user = User.find(params[:id])
  	end
end
