class MoviesService

  def conn
    Faraday.new(url: "https://api.themoviedb.org/3/") do |faraday|
      faraday.params["api_key"] = ENV['movie_key']
    end
  end

  def get_data(url)
    response = conn.get(url)
    data     = response.body
    JSON.parse(data, symbolize_names: true)
  end

  def top_40_movies
    movie_data_page_1 = get_data('movie/top_rated')
    movie_data_page_2 = get_data('movie/top_rated?page=2')
    results = movie_data_page_1[:results]
    movie_data_page_2[:results].each do |result|
      results << result
    end
    results
  end
end
