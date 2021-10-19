require 'rails_helper'

RSpec.describe 'movies show page' do
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
      visit(movie_path(118340))
    end

    it 'has a button to create a viewing party', :vcr do
      click_button("Create Viewing Party")
      expect(current_path).to eq(new_party_path)
    end

    it 'has the movie info', :vcr do
      expect(page).to have_content("Guardians of the Galaxy")
      expect(page).to have_content("Vote Average: 7.9")
      expect(page).to have_content("2 hour(s) 1 minute(s)")
      expect(page).to have_content("Action, Science Fiction, Adventure")
      expect(page).to have_content("Overview: Light years from Earth, 26 years after being abducted, Peter Quill finds himself the prime target of a manhunt after discovering an orb wanted by Ronan the Accuser.")
      expect(page).to have_content("Chris Pratt as Peter Quill / Star-Lord")
      expect(page).to have_content("Author: Binawoo")
      expect(page).to have_content("10 Reviews")
      expect(page).to have_content("This movie was so AWESOME! I loved it all and i had a bad day before watching it but it turned it around. I love action packed movies and this was great.")
    end

    it 'lists similar movies', :vcr do
      expect(page).to have_content("Recommended Movies")
      expect(page).to have_content("Spider-Man")
      click_link "Spider-Man"
      expect(current_path).to eq(movie_path(557))
    end
  end

  describe 'logging out' do
    before :each do
      @user = User.create!(email: "ruby@rubymail.com", password: "turing", password_confirmation: "turing")
      
      visit root_path

      fill_in :email, with: @user.email
      fill_in :password, with: @user.password

      click_button "Sign In"
      visit movie_path(118340)
    end

    describe 'dashboard page' do
      it 'can log out', :vcr do
        click_button 'Log Out'
        expect(current_path).to eq(root_path)

        visit dashboard_path
        expect(current_path).to eq(root_path)
        expect(page).to have_content("You shall not pass")
      end
    end
  end
end
