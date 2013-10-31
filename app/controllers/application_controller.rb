class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authorize
  # before_action :settings_setup

  protected

    def store_location
      @return_to = request.referer if request.get?
    end

  	def current_user
  		@current_user ||= User.find(session[:user_id]) if session[:user_id]
  	end
  	helper_method :current_user

    def current_resource
      nil
    end

    def current_permission
      @current_permission ||= Permission.new(current_user)
    end

    def authorize
      unless current_permission.permit?(params[:controller], params[:action], current_resource)
        redirect_to login_url, alert: "Please login."
      end
    end

    delegate :permit?, to: :current_permission
    helper_method :permit?

    # def settings_setup
    #   @settings[:title] = ENV['SITE_TITLE']
    #   @settings[:tagline] = ENV['SITE_TAGLINE']
    #   @settings[:email] = ENV['SITE_EMAIL']
    # end

end
