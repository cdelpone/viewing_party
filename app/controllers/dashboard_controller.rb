class DashboardController < ApplicationController
  before_action :require_user

  def index
  end

  private
  def require_user
    if !current_user
      flash[:alert] = "You shall not pass"
      redirect_to root_path
    end
  end
end
