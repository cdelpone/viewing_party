class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    new_user = User.create(user_params)
    redirect_to dashboard_path
  end


private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
