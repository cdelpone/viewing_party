class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    new_user = User.new(user_params)
    if new_user.save
      session[:user_id] = new_user.id
      redirect_to dashboard_path
    else
      flash[:error] = "There's an issue with your information."
      redirect_to new_user_path
    end
  end


private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
