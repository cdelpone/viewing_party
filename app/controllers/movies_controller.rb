class MoviesController < ApplicationController
  before_action :require_user

  def index
    @movies = if params[:movie_title]
                MoviesFacade.find_movie_by_title(params[:movie_title])
              elsif params[:now_playing]
                MoviesFacade.now_playing
              else
                MoviesFacade.top_40_movies
              end
  end

  def show
    @movie          = MoviesFacade.find_movie_by_id(params[:id])
    @cast           = MoviesFacade.cast_by_id(params[:id])
    @reviews        = MoviesFacade.reviews_by_id(params[:id])
    @similar_movies = MoviesFacade.similar_movies(params[:id])
  end
end
