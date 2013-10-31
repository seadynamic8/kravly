class PasswordResetsController < ApplicationController

  def new
  end

  def create
  	user = User.find_by_email(params[:email])
  	if user
  		user.send_password_reset
  		redirect_to login_path, notice: "Email sent with password reset instructions."
  	else
  		flash.now[:alert] = "Email not found!"
  		render :new
  	end
  end

  def edit
  	@user = User.find_by_password_reset_token(params[:id])
  	if @user == nil
  		redirect_to new_password_reset_path, alert: "Password reset link has expired."
  	end
  end

  def update
  	@user = User.find_by_password_reset_token!(params[:id])
  	if @user.password_reset_sent_at < 2.hours.ago
  		redirect_to new_password_reset_path, alert: "Password reset link has expired."
  	elsif @user.update_attributes(user_params)
  		@user.password_reset_token = nil
  		@user.save!
  		redirect_to login_path, notice: "Password has been reset."
  	else
  		render :edit
  	end
  end

  private

  	def user_params
  		params.require(:user).permit(:password, :password_confirmation)
  	end
end
