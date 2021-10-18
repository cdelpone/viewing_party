require 'rails_helper'
# rspec spec/services/movie_service_spec.rb
RSpec.describe 'movies api' do
    before :each do
      @user = User.create!(email: "ruby@rubymail.com", password: "turing", password_confirmation: "turing")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      @json_response_1 = File.read('spec/fixtures/top_40_movies_1.json')
      json_response_2 = File.read('spec/fixtures/top_40_movies_2.json')

      stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['movie_key']}").
      to_return(status: 200, body: @json_response_1, headers: {})

      stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['movie_key']}&page=2").
      to_return(status: 200, body: json_response_2, headers: {})

      fc_response_1 = File.read('spec/fixtures/fight_club_1.json')
      fc_response_2 = File.read('spec/fixtures/fight_club_2.json')

      stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['movie_key']}&query=Fight Club").
      to_return(status: 200, body: fc_response_1, headers: {})

      stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['movie_key']}&query=Fight Club&page=2").
      to_return(status: 200, body: fc_response_2, headers: {})

      @movie_service = MoviesService.new
    end

    it 'exists' do
      expect(@movie_service).to be_an_instance_of(MoviesService)
    end

    it 'gets data' do
      # url = "movies/top_rated"
      # expect(@movie_service.get_data("movies/top_rated")).to eq(@json_response_1)
    end
end
