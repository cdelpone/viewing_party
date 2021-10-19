class Movie
  attr_reader :runtime,
              :genres,
              :id,
              :overview,
              :title,
              :vote_average

  def initialize(data)
    @runtime           = data[:runtime]
    @genres            = data[:genres]
    @id                = data[:id]
    @overview          = data[:overview]
    @title             = data[:title]
    @vote_average      = data[:vote_average]
  end

  def genre_names
    genres.map do |genre|
      genre[:name]
    end
  end

  def formatted_runtime
    hours = @runtime / 60
    rest = @runtime % 60
    "#{hours} hour(s) #{rest} minute(s)"
  end
end
