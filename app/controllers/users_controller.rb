class UsersController < ApplicationController
	before_action :current_resource, only: [:edit, :update, :destroy, :settings, :boards, :ideas]

  def new
    @user = User.new
    store_location
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      UserMailer.signup_confirmation(@user).deliver
      redirect_to boards_user_path(@user), notice: "Thank you for signing up!"
    else
      render :new
    end
  end

  def edit
    store_location
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to boards_user_path(@user), notice: "User was updated."
    else
      render :edit
    end
  end

  def destroy
    UserMailer.goodbye_message(@user).deliver
    @user.destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "User was deleted."
  end

  def settings
  end

  def boards
    @boards = @user.boards.page(params[:page]).per_page(9)

    if request.path != boards_user_path(@user)
      redirect_to boards_user_path(@user), status: :moved_permanently
    end
  end

  def ideas
    @ideas = @user.ideas.page(params[:page]).per_page(9)

    if request.path != ideas_user_path(@user)
      redirect_to ideas_user_path(@user), status: :moved_permanently
    end
  end

  private

  	def current_resource
  		@user = User.friendly.find(params[:id]) if params[:id]

  	end

    def user_params
      params.require(:user).permit(:username, :email, :firstname, :lastname, 
                                   :password, :password_confirmation, 
                                   :avatar, :avatar_cache, :remote_avatar_url,
                                   :about, :location, :website)
    end
end
