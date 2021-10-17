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

      @movie_data = File.read('spec/fixtures/guardians_info.json')

      stub_request(:get, "https://api.themoviedb.org/3/movie/118540?api_key=#{ENV['movie_key']}").
      to_return(status: 200, body: @movie_data, headers: {})

      @credit_data = File.read('spec/fixtures/guardians_credits.json')

      stub_request(:get, "https://api.themoviedb.org/3/movie/118540/credits?api_key=#{ENV['movie_key']}").
      to_return(status: 200, body: @credit_data, headers: {})

      visit(movie_path(118540))
    end

    it 'has a button to create a viewing party' do
      click_button("Create Viewing Party")
      expect(current_path).to eq(new_party_path)
    end

    it 'has the movie info' do
      parsed_data = JSON.parse(@movie_data)

      expect(page).to have_content(parsed_data['title'])
      expect(page).to have_content(parsed_data['vote_average'])
      expect(page).to have_content("2 hour(s) 1 minute(s)")
      expect(page).to have_content("Action, Science Fiction, Adventure")
      expect(page).to have_content(parsed_data['overview'])
      expect(page).to have_content("Chris Pratt as Peter Quill / Star-Lord")

      ##Count of total reviews
      #movie/:id/reviews [:total_results]
      ##Reviewer author and information
      # [:results][:]
    end
  end

end
