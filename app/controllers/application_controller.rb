class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    return if current_user

    flash[:alert] = 'You shall not pass'
    redirect_to root_path
  end
end
