class PartiesController < ApplicationController
  before_action :require_user
  def new
    @party = Party.new
    @movie_title = params[:movie_title]
    @movie_runtime = params[:runtime].to_i
  end
end
