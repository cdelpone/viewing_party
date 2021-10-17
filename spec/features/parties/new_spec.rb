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
      @ruby = User.create!(email: "ruby@rubymail.com", password: "turing", password_confirmation: "turing")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@ruby)

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
      @movie_title = @parsed_data['title']

      @python = User.create!(email: "python@pythonmail.com", password: "potato", password_confirmation: "potato")
      @java   = User.create!(email: "java@javamail.com", password: "banana", password_confirmation: "banana")
      @yaml   = User.create(email: "yaml@gmail.com", password: "potato", password_confirmation: "potato")

      @ruby.friendships.create!(friend: @python)
      @ruby.friendships.create!(friend: @java)
      @ruby.friendships.create!(friend: @yaml)

      visit(movie_path(118340))
      click_button("Create Viewing Party")
    end

    it 'has the movie title above the form' do
      expect(page).to have_content(@movie_title)
    end

    it 'has all appropriate fields' do
      expect(page).to have_field(:duration, with: 121)
      expect(page).to have_field(:date)
      expect(page).to have_field(:time)
      expect(page).to have_field("#{@python.id}")
      expect(page).to have_field("#{@yaml.id}")
      expect(page).to have_field("#{@java.id}")
    end

    it 'can make a party' do
      fill_in(:duration, with: 180)
      fill_in(:date, with: "2018-01-02")
      fill_in(:time, with: "04:30:00 UST")
      check("#{@python.id}")
      check("#{@yaml.id}")
      click_button("Create Party")

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_link(@movie_title)
      expect(page).to have_content("Tuesday, January 2, 2018 at 04:30AM")
      expect(page).to have_content("Hosting")
      expect(page).to have_content("Attending:")
      expect(page).to have_content(@python.email)
      expect(page).to have_content(@yaml.email)
    end

    it 'does not allow for the date to be blank' do
      fill_in(:duration, with: 180)
      fill_in(:time, with: "04:30:00 UST")
      check("#{@python.id}")
      check("#{@yaml.id}")
      click_button("Create Party")

      expect(current_path).to eq(new_party_path)
      expect(page).to have_content("Invalid input. Please try again.")
      expect(page).to have_content(@movie_title)
      expect(page).to have_field(:duration, with: 121)
    end
  end
end
