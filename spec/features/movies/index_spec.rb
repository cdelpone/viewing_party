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
      visit movies_path
    end

    it 'lists 40 titles of top movies as a link to the movie page', :vcr do
      expect(page).to have_link("Dilwale Dulhania Le Jayenge")
      expect(page).to have_link("A Silent Voice: The Movie")

      click_link("Dilwale Dulhania Le Jayenge")

      expect(current_path).to eq(movie_path(19404))
    end

    it 'lists vote average for each movie', :vcr do
      within '#movie-19404' do
        expect(page).to have_content("Vote Average: 8.8")
      end

      within '#movie-378064' do
        expect(page).to have_content("Vote Average: 8.4")
      end
    end

    it 'has a button for find top movies', :vcr do
      expect(page).to have_button('Find Top Movies')
      click_button('Find Top Movies')
      expect(current_path).to eq(movies_path)
    end

    it 'has a movie search form', :vcr do
      fill_in(:movie_title, with: 'Fight Club')
      click_button('Find Movies')
      expect(current_path).to eq(movies_path)
      expect(page).to have_content('Fight Club')
      expect(page).to have_content('Barrio Brawler')
    end

    it 'has a button for now playing', :vcr do
      expect(page).to have_button('Find Now Playing')
      click_button('Find Now Playing')
      expect(current_path).to eq(movies_path)
      expect(page).to have_content("Venom: Let There Be Carnage")
    end
  end
end
