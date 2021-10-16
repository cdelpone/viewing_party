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

    it 'lists 40 titles of top movies' do
      json_response_1 = File.read('spec/fixtures/top_40_movies_1.json')
      # json_response_2 = File.read('spec/fixtures/top_40_movies_2.json')

      stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated").
        with(params: {'api_key'=> ENV['movie_key']}).
        to_return(status: 200, body: json_response_1, headers: {})
      # stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['movie_key']}&page=2").
      #   to_return(status: 200, body: json_response_2, headers: {})

      expect(page).to have_content("Dilwale Dulhania Le Jayenge")
      # expect(page).to have_content("Life in a Year")
    end
  end
end

# json_response = File.read('spec/fixtures/members_of_the_senate.json')
#         stub_request(:get, "https://api.propublica.org/congress/v1/116/senate/members.json").
#           with(headers: {'X-Api-Key'=> ENV['govt_api_key']}).
#           to_return(status: 200, body: json_response, headers: {})
