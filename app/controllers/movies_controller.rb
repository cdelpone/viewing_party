class MoviesController < ApplicationController
  before_action :require_user

  def index
    if params[:movie_title]
      @movies = MoviesFacade.find_by_title(params[:movie_title])
    elsif params[:now_playing]
      @movies = MoviesFacade.now_playing
    else
      @movies = MoviesFacade.top_40_movies
    end
  end

  def show
    @movie = MoviesFacade.find_movie_by_id(params[:id])
    @cast = MoviesFacade.cast_by_id(params[:id])
    @reviews = MoviesFacade.reviews_by_id(params[:id])
  end
end
