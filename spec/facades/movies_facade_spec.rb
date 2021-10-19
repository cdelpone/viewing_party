require 'rails_helper'
# rspec spec/facades/movies_facade_spec.rb
RSpec.describe 'movies facade' do
  before :each do
    json_response_1 = File.read('spec/fixtures/top_40_movies_1.json')
    json_response_2 = File.read('spec/fixtures/top_40_movies_2.json')

    stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['movie_key']}").
    to_return(status: 200, body: json_response_1, headers: {})

    stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['movie_key']}&page=2").
    to_return(status: 200, body: json_response_2, headers: {})

    fc_response_1 = File.read('spec/fixtures/fight_club_1.json')
    fc_response_2 = File.read('spec/fixtures/fight_club_2.json')

    stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['movie_key']}&query=Fight Club").
    to_return(status: 200, body: fc_response_1, headers: {})

    stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['movie_key']}&query=Fight Club&page=2").
    to_return(status: 200, body: fc_response_2, headers: {})

    movie_data = File.read('spec/fixtures/guardians_info.json')

    stub_request(:get, "https://api.themoviedb.org/3/movie/118340?api_key=#{ENV['movie_key']}").
    to_return(status: 200, body: movie_data, headers: {})

    credit_data = File.read('spec/fixtures/guardians_credits.json')

    stub_request(:get, "https://api.themoviedb.org/3/movie/118340/credits?api_key=#{ENV['movie_key']}").
    to_return(status: 200, body: credit_data, headers: {})

    reviews = File.read('spec/fixtures/guardians_reviews.json')

    stub_request(:get, "https://api.themoviedb.org/3/movie/118340/reviews?api_key=#{ENV['movie_key']}").
    to_return(status: 200, body: reviews, headers: {})

    now_playing = File.read('spec/fixtures/now_playing.json')

    stub_request(:get, "https://api.themoviedb.org/3/movie/now_playing?api_key=#{ENV['movie_key']}").
    to_return(status: 200, body: now_playing, headers: {})

    similar_movies = File.read('spec/fixtures/similar_movies.json')

    stub_request(:get, "https://api.themoviedb.org/3/movie/118340/similar?api_key=#{ENV['movie_key']}").
    to_return(status: 200, body: similar_movies, headers: {})
  end

  it 'returns top 40 movies' do
    expect(MoviesFacade.top_40_movies).to be_an(Array)
    expect(MoviesFacade.top_40_movies.count).to eq(40)
  end

  it 'can find a movie by title' do
    expect(MoviesFacade.find_by_title("Fight Club")).to be_an(Array)
    expect(MoviesFacade.find_by_title("Fight Club").first).to be_a Movie
  end

  it 'can find a movie by id' do
    expect(MoviesFacade.find_movie_by_id(118340)).to be_a Movie
  end

  it 'can return an array with the first ten cast members by movie id' do
    expect(MoviesFacade.cast_by_id(118340)).to be_an(Array)
    expect(MoviesFacade.cast_by_id(118340).count).to eq(10)
    expect(MoviesFacade.cast_by_id(118340).first).to be_a CastMember
  end

  it 'can return an array with reviews by movie id' do
    expect(MoviesFacade.reviews_by_id(118340)).to be_an(Array)
    expect(MoviesFacade.reviews_by_id(118340).first).to be_a Review
  end

   it 'can return movies now playing' do
     expect(MoviesFacade.now_playing).to be_an(Array)
     expect(MoviesFacade.now_playing.count).to eq(20)
   end

   it 'can return similar movies' do
     expect(MoviesFacade.similar_movies(118340)).to be_an(Array)
     expect(MoviesFacade.similar_movies(118340).count).to eq(3)
   end
end
