class MoviesController < ApplicationController
  before_action :require_user

  def index
    movie_service = MoviesService.new
    @movies = movie_service.top_40_movies
    binding.pry
  end
end
