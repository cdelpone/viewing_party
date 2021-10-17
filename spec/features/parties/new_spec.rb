require 'rails_helper'

RSpec.describe 'New Party Form' do
  describe 'invalid user' do
    it 'does not allow access before log in' do
      visit(new_party_path)
      expect(current_path).to eq(root_path)
      expect(page).to have_content("You shall not pass")
    end
  end

  describe 'valid user' do
    before :each do
      @user = User.create!(email: "ruby@rubymail.com", password: "turing", password_confirmation: "turing")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      @movie_data = File.read('spec/fixtures/guardians_info.json')

      stub_request(:get, "https://api.themoviedb.org/3/movie/118340?api_key=#{ENV['movie_key']}").
      to_return(status: 200, body: @movie_data, headers: {})

      @credit_data = File.read('spec/fixtures/guardians_credits.json')

      stub_request(:get, "https://api.themoviedb.org/3/movie/118340/credits?api_key=#{ENV['movie_key']}").
      to_return(status: 200, body: @credit_data, headers: {})

      @reviews = File.read('spec/fixtures/guardians_reviews.json')

      stub_request(:get, "https://api.themoviedb.org/3/movie/118340/reviews?api_key=#{ENV['movie_key']}").
      to_return(status: 200, body: @reviews, headers: {})

      @parsed_data = JSON.parse(@movie_data)

      @python = User.create!(email: "python@pythonmail.com", password: "potato", password_confirmation: "potato")
      @java   = User.create!(email: "java@javamail.com", password: "banana", password_confirmation: "banana")
      @ruby   = User.create(email: "ruby@gmail.com", password: "potato", password_confirmation: "potato")

      @user.friendships.create!(friend: @python)
      @user.friendships.create!(friend: @java)
      @user.friendships.create!(friend: @ruby)

      visit(movie_path(118340))
      click_button("Create Viewing Party")
    end

    it 'has the movie title above the form' do
      expect(page).to have_content(@parsed_data['title'])
    end

    it 'has all appropriate fields' do
      expect(page).to have_field('party[duration]', with: 121)
      expect(page).to have_field('party[date]')
      expect(page).to have_field('party[time]')
      expect(page).to have_field("party[#{@python.id}]")
      expect(page).to have_field("party[#{@ruby.id}]")
      expect(page).to have_field("party[#{@java.id}]")
    end
  end

end
