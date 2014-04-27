class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    p 'what?'
    if @user = User.where(username: params[:user][:username].strip).present?
      p 'dinosaur'
      redirect_to signin_path
    else
      p 'sandwich'
      if @user = User.create(params[:user])
        p 'nuke'
        redirect_to signin_path
      else
        p 'baaaack'
        redirect_to back
      end
    end
  end
end
