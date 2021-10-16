class Movie
  attr_reader :adult,
              :backdrop_path,
              :runtime,
              :genre_ids,
              :genres,
              :id,
              :original_language,
              :original_title,
              :overview,
              :popularity,
              :poster_path,
              :release_date,
              :title,
              :videos,
              :vote_average,
              :vote_count

  def initialize(data)
    @adult             = data[:adult]
    @runtime           = data[:runtime]
    @backdrop_path     = data[:backdrop_path]
    @genre_ids         = data[:genre_ids]
    @genres            = data[:genres]
    @id                = data[:id]
    @original_language = data[:original_language]
    @original_title    = data[:original_title]
    @overview          = data[:overview]
    @popularity        = data[:popularity]
    @poster_path       = data[:poster_path]
    @release_date      = data[:release_date]
    @title             = data[:title]
    @videos            = data[:videos]
    @vote_average      = data[:vote_average]
    @vote_count        = data[:vote_count]
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
