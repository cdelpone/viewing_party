require 'rails_helper'

RSpec.describe 'discover index', type: :feature do
  describe 'invalid user' do
    it 'is not accessible without logging in' do
      visit discover_path
      expect(current_path).to eq(root_path)
      expect(page).to have_content("You shall not pass")
    end
  end

  describe 'valid user' do
    before :each do
      @user = User.create!(email: "ruby@rubymail.com", password: "turing", password_confirmation: "turing")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit discover_path
    end

    it 'has a button for find top movies', :vcr do
      expect(page).to have_button('Find Top Movies')
      click_button('Find Top Movies')
      expect(current_path).to eq(movies_path)
    end

    it 'has a movie search form', :vcr do
      within '#search-form' do
        fill_in(:movie_title, with: 'Fight Club')
        click_button('Find Movies')
      end
      expect(current_path).to eq(movies_path)
      expect(page).to have_content('Fight Club')
      expect(page).to have_content('Barrio Brawler')
    end

    it 'has a button to movies now playing', :vcr do
      expect(page).to have_button('Find Now Playing')
      click_button('Find Now Playing')
      expect(current_path).to eq(movies_path)
    end
  end

  describe 'logging out' do
    before :each do
      @user = User.create!(email: "ruby@rubymail.com", password: "turing", password_confirmation: "turing")

      visit root_path

      fill_in :email, with: @user.email
      fill_in :password, with: @user.password

      click_button "Sign In"
      visit discover_path
    end

    describe 'dashboard page' do
      it 'can log out', :vcr do
        click_link 'Log Out'
        expect(current_path).to eq(root_path)

        visit dashboard_path
        expect(current_path).to eq(root_path)
        expect(page).to have_content("You shall not pass")
      end
    end
  end
end
