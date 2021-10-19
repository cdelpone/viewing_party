class DashboardController < ApplicationController
  before_action :require_user

  def index
    return if params[:email].blank?

    if current_user.friends.include?(friend)
      flash[:alert] = "Ya'll are already friends."
    elsif friend
      current_user.friendships.create(friend: friend)
      # current_user.reload
    else
      flash[:alert] = "Sorry, that's an imaginary friend."
    end
  end

  private

  def friend
    User.search_by_email(params[:email])
  end
end
