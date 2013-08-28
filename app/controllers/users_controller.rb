class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy, :settings]
  skip_before_action :authorize, only: [:show, :new, :create, :destroy]

  def index
  end

  def show
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
  end

  def destroy
  end

  def settings
  end

  private

  	def set_user
  		@user = User.find(params[:id])
  	end

    def user_params
      params.require(:user).permit(:username, :email, :firstname, :lastname, 
                                   :password, :password_confirmation)
    end
end
