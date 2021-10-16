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

      @movie_data = File.read('spec/fixtures/dilwale_info.json')

      stub_request(:get, "https://api.themoviedb.org/3/movie/19404?api_key=#{ENV['movie_key']}").
      to_return(status: 200, body: @movie_data, headers: {})

      visit(movie_path(19404))
    end

    it 'has a button to create a viewing party' do
      click_button("Create Viewing Party")
      expect(current_path).to eq(new_party_path)
    end

    it 'has the movie info' do
      parsed_data = JSON.parse(@movie_data)
      save_and_open_page
      expect(page).to have_content(parsed_data['title'])
      expect(page).to have_content(parsed_data['vote_average'])
      expect(page).to have_content("3 hour(s) 10 minute(s)")
      expect(page).to have_content("Comedy, Drama, Romance")
      expect(page).to have_content(parsed_data['overview'])

      ##First ten cast members
      #movie/:id/credits [:cast]
      ##Count of total reviews
      #movie/:id/reviews [:total_results]
      ##Reviewer author and information
      # [:results][:]
    end
  end

end
