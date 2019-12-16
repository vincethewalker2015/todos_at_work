class SessionsController < ApplicationController

  def new
    
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      cookies.signed[:user_id] = user.id
      flash[:success] = "Log in Sucessfull"
      redirect_to user
    else
      flash.now[:danger] = "Login Error.."
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You are Logged Out"
    redirect_to root_path
  end

end