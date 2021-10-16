class MoviesController < ApplicationController
  before_action :require_user

  def index
    movie_service = MoviesService.new
    if params[:movie_title]
      @movies = movie_service.find_by_title(params[:movie_title])
    else
      @movies = movie_service.top_40_movies
    end
  end

  def show

  end
end
