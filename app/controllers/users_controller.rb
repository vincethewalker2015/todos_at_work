class UsersController < ApplicationController
  before_action :require_user, except: [:index, :show,]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Profile has been created"
      redirect_to users_path(@user)
    else
      flash[:danger] = "Ouch!! That didn't work.. Try that again"
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash.now[:success] = "Your Details have been updated"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    session[:user_id] = nil
    flash.now[:success] = "User Deleted"
    redirect_to root_path
  end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end



end
