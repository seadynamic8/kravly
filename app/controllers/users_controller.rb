class UsersController < ApplicationController
	before_action :current_resource, only: [:edit, :update, :destroy, :settings, :boards, :ideas,
                                          :change_password, :update_password]

  def index
    @users = User.all
  end

  def new
    @user = User.new
    store_location
  end

  def create
    @user = User.new(user_params)
    logger.debug "*****updating_password = #{@user.updating_password}"
    if @user.save
      session[:user_id] = @user.id
      UserMailer.signup_confirmation(@user).deliver
      flash[:notice] = "Thank you for signing up!"
      if params[:return_to]
        redirect_to params[:return_to]
      else
        redirect_to boards_user_path(@user)
      end
    else
      render :new
    end
  end

  def edit
    store_location
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to boards_user_path(@user), notice: "Your account was updated."
    else
      render :edit
    end
  end

  def destroy
    UserMailer.goodbye_message(@user).deliver
    @user.destroy
    session[:user_id] = nil
    redirect_to root_url
  end

  def settings
  end

  def boards
    @boards = @user.boards.recent.page(params[:page]).per_page(12)
  end

  def ideas
    @ideas = @user.ideas.recent.page(params[:page]).per_page(12)
  end

  def votes
    @user_votes = @user.user_votes.page(params[:page]).per_page(12)
  end

  def change_password
  end

  def update_password
    if @user.authenticate(params[:old_password])
      if @user.password_match?(user_params)
        @user.updating_password = true
        if @user.update_attributes(user_params)
          redirect_to settings_user_path(@user), notice: "Password successfully updated."
        else
          flash.now[:alert] = "Password not changed."
          render :change_password
        end
      else
        flash.now[:alert] = "New Password Mismatch!"
        render :change_password
      end
    else
      flash.now[:alert] = "Old Password Incorrect!"
      render :change_password
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
                                   :about, :location, :website, :display)
    end
end
