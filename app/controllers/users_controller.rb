class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy, :settings, :ideas]
  skip_before_action :authorize, only: [:show, :new, :create, :ideas]

  def show
    @boards = @user.boards.page(params[:page]).per_page(9)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: "Thank you for signing up!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "User was deleted."
  end

  def settings
  end

  def ideas
    @ideas = @user.ideas.page(params[:page]).per_page(9)
  end

  private

  	def set_user
  		@user = User.find(params[:id])
  	end

    def user_params
      params.require(:user).permit(:username, :email, :firstname, :lastname, 
                                   :password, :password_confirmation, :avatar, :avatar_cache)
    end
end
