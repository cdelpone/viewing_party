class DashboardController < ApplicationController
  before_action :require_user

  def index
    if params[:email].present?
      friend = User.search_by_email(params[:email])
      if current_user.friends.include?(friend)
        flash[:alert] = "Ya'll are already friends."
      elsif friend
        current_user.friendships.create(friend: friend)
        # current_user.reload
      else
        flash[:alert] = "Sorry, that's an imaginary friend."
      end
    end
  end
end
