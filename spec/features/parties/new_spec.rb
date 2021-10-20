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

      @python = User.create!(email: "python@pythonmail.com", password: "potato", password_confirmation: "potato")
      @java   = User.create!(email: "java@javamail.com", password: "banana", password_confirmation: "banana")
      @yaml   = User.create(email: "yaml@gmail.com", password: "potato", password_confirmation: "potato")

      @ruby.friendships.create!(friend: @python)
      @ruby.friendships.create!(friend: @java)
      @ruby.friendships.create!(friend: @yaml)

      visit(movie_path(118340))
      click_button("Create Viewing Party")
    end

    it 'has the movie title above the form', :vcr do
      expect(page).to have_content("Guardians of the Galaxy")
    end

    it 'has all appropriate fields', :vcr do
      expect(page).to have_field(:duration, with: 121)
      expect(page).to have_field(:date)
      expect(page).to have_field(:time)
      expect(page).to have_field("#{@python.id}")
      expect(page).to have_field("#{@yaml.id}")
      expect(page).to have_field("#{@java.id}")
    end

    it 'can make a party', :vcr do
      fill_in(:duration, with: 180)
      fill_in(:date, with: "2018-01-02")
      fill_in(:time, with: "04:30:00 UST")
      check("#{@python.id}")
      check("#{@yaml.id}")
      click_button("Create Party")

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_link("Guardians of the Galaxy")
      expect(page).to have_content("Tuesday, January 2, 2018 at 04:30AM")
      expect(page).to have_content("Hosting")
      expect(page).to have_content("Attending:")
      expect(page).to have_content(@python.email)
      expect(page).to have_content(@yaml.email)
    end

    it 'does not allow for the date to be blank', :vcr do
      fill_in(:duration, with: 180)
      fill_in(:time, with: "04:30:00 UST")
      check("#{@python.id}")
      check("#{@yaml.id}")
      click_button("Create Party")

      expect(current_path).to eq(new_party_path)
      expect(page).to have_content("Invalid input. Please try again.")
      expect(page).to have_content("Guardians of the Galaxy")
      expect(page).to have_field(:duration, with: 121)
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
      click_button("Create Viewing Party")
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
