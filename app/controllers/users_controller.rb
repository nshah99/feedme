class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
      if @user.save
        redirect_to @user
      else
         render 'new'
      end
  end

  def update
  end

  def delete
  end
  def index
    @user = User.all
  end
  def show
    @user = User.find(params[:id])
  end
  
  private
  def user_params
      params.require(:user).permit(:email,:password,:name,:password_confirmation)
  end
end
