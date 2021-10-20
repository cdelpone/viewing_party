require 'rails_helper'

RSpec.describe 'movies api' do
  before :each do
    @user = User.create!(email: "ruby@rubymail.com", password: "turing", password_confirmation: "turing")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it 'gets data from the API', :vcr do
    response = MoviesService.get_data('movie/now_playing')
    expect(response).to be_a(Hash)
    expect(response[:results]).to be_an(Array)

    response[:results].each do |movie|
      expect(movie[:id]).to be_an(Integer)
      expect(movie[:title]).to be_a(String)
      expect(movie[:vote_average]).to be_a(Float).or be_an(Integer)
    end
  end
end
