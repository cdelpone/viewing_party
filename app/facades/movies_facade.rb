class MoviesFacade
  def self.top_40_movies
    page_1 = MoviesService.get_data('movie/top_rated')
    page_2 = MoviesService.get_data('movie/top_rated?page=2')
    results = page_1[:results] + page_2[:results]
    create_movies(results)
  end

  def self.find_by_title(title)
    page_1 = MoviesService.get_data("search/movie?query=#{title}")
    page_2 = MoviesService.get_data("search/movie?query=#{title}&page=2")
    results = page_1[:results] + page_2[:results]
    create_movies(results)
  end

  def self.create_movies(movie_data)
    movie_data.map do |data|
      Movie.new(data)
    end
  end

  def self.find_movie_by_id(id)
    parsed_movie_data = MoviesService.get_data("movie/#{id}")
    Movie.new(parsed_movie_data)
  end

  def self.cast_by_id(id)
    parsed_cast_data = MoviesService.get_data("movie/#{id}/credits")
    parsed_cast_data[:cast].map do |member|
      CastMember.new(member)
    end.take(10)
  end

  def self.reviews_by_id(id)
    parsed_review_data = MoviesService.get_data("movie/#{id}/reviews")
    parsed_review_data[:results].map do |result|
      Review.new(result)
    end
  end
end
