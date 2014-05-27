class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if @user = User.where(username: params[:user][:username].strip).present?
      flash[:notice] = "You already exist, sign in, #{@user.username}"
      redirect_to signin_path
    else
      if @user = User.create(user_params)
        session[:user_id] = @user.id
        flash[:notice] = "Welcome, #{@user.username}"
        redirect_to root_path
      else
        redirect_to back
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
