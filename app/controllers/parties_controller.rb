class PartiesController < ApplicationController
  before_action :require_user
  def new
    @party         = Party.new
    @movie_title   = params[:movie_title]
    @movie_runtime = params[:runtime].to_i
    @movie_id      = params[:movie_id]
  end

  def create
    party = current_user.parties.create(party_params)
    party.invite_friends_by_ids(included_friend_ids)
    redirect_to dashboard_path
  end

  private

  def party_params
    params.require(:party)
          .permit(:duration, :date, :time, :movie_id, :movie_title)
  end

  def included_friend_ids
    keys = params[:party].keys
    keys.find_all do |friend_id|
      friend_id.to_i > 0 && params[:party][friend_id] == '1'
    end
  end
end
