class PartiesController < ApplicationController
  before_action :require_user

  def new
    @movie_title   = params[:movie_title]
    @movie_runtime = params[:runtime].to_i
    @movie_id      = params[:movie_id]
  end

  def create
    party = current_user.parties.create(party_params)
    if party.save
      party.invite_friends_by_ids(included_friend_ids)
      redirect_to dashboard_path
    else
      flash[:alert] = "Invalid input. Please try again."
      redirect_to new_party_path(movie_params)
    end
  end

  private

  def party_params
    params.permit(:duration, :date, :time, :movie_id, :movie_title)
  end

  def movie_params
    {
      movie_title: params[:movie_title],
      runtime: params[:movie_runtime].to_i,
      movie_id: params[:movie_id]
    }
  end

  def included_friend_ids
    keys = params.keys
    keys.find_all do |friend_id|
      friend_id.to_i > 0 && params[friend_id] == '1'
    end
  end
end
