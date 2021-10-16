require 'rails_helper'

RSpec.describe 'movies index', type: :feature do
  describe 'invalid user' do
    before(:each) do
      visit movies_path
    end

    it 'is not accessible without logging in' do
      expect(current_path).to eq(root_path)
      expect(page).to have_content("You shall not pass")
    end
  end

  describe 'valid user' do
    before :each do
      @user = User.create!(email: "ruby@rubymail.com", password: "turing", password_confirmation: "turing")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

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

      movie_data = File.read('spec/fixtures/dilwale_info.json')

      stub_request(:get, "https://api.themoviedb.org/3/movie/19404?api_key=#{ENV['movie_key']}").
      to_return(status: 200, body: movie_data, headers: {})

      visit movies_path
    end

    it 'lists 40 titles of top movies as a link to the movie page' do
      expect(page).to have_link("Dilwale Dulhania Le Jayenge")
      expect(page).to have_link("Life in a Year")

      click_link("Dilwale Dulhania Le Jayenge")

      expect(current_path).to eq(movie_path(19404))
    end

    it 'lists vote average for each movie' do
      within '#movie-19404' do
        expect(page).to have_content("Vote Average: 8.8")
      end

      within '#movie-447362' do
        expect(page).to have_content("Vote Average: 8.4")
      end
    end

    it 'has a button for find top movies' do
      expect(page).to have_button('Find Top Movies')
      click_button('Find Top Movies')
      expect(current_path).to eq(movies_path)
    end

    it 'has a movie search form' do
      fill_in(:movie_title, with: 'Fight Club')
      click_button('Find Movies')
      expect(current_path).to eq(movies_path)
      expect(page).to have_content('Fight Club')
      expect(page).to have_content('Barrio Brawler')
    end
  end
end
