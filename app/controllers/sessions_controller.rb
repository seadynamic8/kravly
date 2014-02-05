class SessionsController < ApplicationController

  def new
    store_location
  end

  def create
  	user = User.find_by_username(params[:username])
  	if user.nil?
  		user = User.find_by_email(params[:username])
  	end
  	if user && user.authenticate(params[:password])
  		session[:user_id] = user.id
      flash[:notice] = "Welcome!"
      if params[:return_to] && ( params[:return_to] != root_url )
        redirect_to params[:return_to]
      else
    		redirect_to discover_path
      end
  	else
  		flash.now[:alert] = "Username or Password is invalid!"
  		render :new
  	end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
