class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authorize

  protected

  	def authorize
  		redirect_to login_url, alert: "Please login." if current_user.nil?
  	end

  private

  	def current_user
  		@current_user ||= User.find(session[:user_id]) if session[:user_id]
  	end
  	helper_method :current_user

end
