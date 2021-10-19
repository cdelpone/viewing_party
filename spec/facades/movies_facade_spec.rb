require 'rails_helper'
# rspec spec/facades/movies_facade_spec.rb
RSpec.describe 'movies facade' do
  
  it 'returns top 40 movies', :vcr do
    expect(MoviesFacade.top_40_movies).to be_an(Array)
    expect(MoviesFacade.top_40_movies.count).to eq(40)
  end

  it 'can find a movie by title', :vcr do
    expect(MoviesFacade.find_by_title("Fight Club")).to be_an(Array)
    expect(MoviesFacade.find_by_title("Fight Club").first).to be_a Movie
  end

  it 'can find a movie by id', :vcr do
    expect(MoviesFacade.find_movie_by_id(118340)).to be_a Movie
  end

  it 'can return an array with the first ten cast members by movie id', :vcr do
    expect(MoviesFacade.cast_by_id(118340)).to be_an(Array)
    expect(MoviesFacade.cast_by_id(118340).count).to eq(10)
    expect(MoviesFacade.cast_by_id(118340).first).to be_a CastMember
  end

  it 'can return an array with reviews by movie id', :vcr do
    expect(MoviesFacade.reviews_by_id(118340)).to be_an(Array)
    expect(MoviesFacade.reviews_by_id(118340).first).to be_a Review
  end

   it 'can return movies now playing', :vcr do
     expect(MoviesFacade.now_playing).to be_an(Array)
     expect(MoviesFacade.now_playing.count).to eq(20)
   end

   it 'can return similar movies', :vcr do
     expect(MoviesFacade.similar_movies(118340)).to be_an(Array)
     expect(MoviesFacade.similar_movies(118340).count).to eq(3)
   end
end
