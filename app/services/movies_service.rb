class MoviesService

  def self.conn
    Faraday.new(url: "https://api.themoviedb.org/3/") do |faraday|
      faraday.params["api_key"] = ENV['movie_key']
    end
  end

  def self.get_data(url)
    response = conn.get(url)
    data     = response.body

    JSON.parse(data, symbolize_names: true)
  end
end
