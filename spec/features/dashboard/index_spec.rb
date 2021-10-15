require 'rails_helper'

RSpec.describe 'dashboard' do
  describe 'invalid user' do
    before(:each) do
      visit dashboard_path
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

      visit dashboard_path
    end

    it 'welcomes a user' do
      expect(page).to have_content("Welcome, #{@user.email}!")
    end

    it 'has a discover movies button' do
      expect(page).to have_button("Discover Movies")
      click_button "Discover Movies"
      expect(current_path).to eq(discover_path)
    end

    it 'has sections for friends and parties' do
      within '#friends' do
        expect(page).to have_content('Friends')
      end

      within '#parties' do
        expect(page).to have_content('Parties')
      end
    end

    it 'can add a friend' do
      python = User.create!(email: "python@pythonmail.com", password: "potato", password_confirmation: "potato")
      java   = User.create!(email: "java@javamail.com", password: "banana", password_confirmation: "banana")
      ruby = User.create(email: "ruby@gmail.com", password: "potato", password_confirmation: "potato")

      within '#friends' do
        fill_in('email', with: python.email)
        click_button('Add Friend')
      end

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content(python.email)
    end

    it 'does not add friends with bad emails' do
      python = User.create!(email: "python@pythonmail.com", password: "potato", password_confirmation: "potato")
      java   = User.create!(email: "java@javamail.com", password: "banana", password_confirmation: "banana")
      ruby = User.create(email: "ruby@gmail.com", password: "potato", password_confirmation: "potato")

      within '#friends' do
        fill_in('email', with: 'banana')
        click_button('Add Friend')
      end

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Sorry, that's an imaginary friend.")
    end

    it 'has a message when there are no friends' do
      within '#friends' do
        expect(page).to have_content("You don't have any friends.")
      end
    end

    it 'lists existing friends' do
      python = User.create!(email: "python@pythonmail.com", password: "potato", password_confirmation: "potato")
      java   = User.create!(email: "java@javamail.com", password: "banana", password_confirmation: "banana")
      ruby   = User.create(email: "ruby@gmail.com", password: "potato", password_confirmation: "potato")

      @user.friendships.create!(friend: python)
      @user.friendships.create!(friend: java)
      @user.friendships.create!(friend: ruby)

      visit current_path

      within '#friends' do
        expect(page).to have_content(python.email)
        expect(page).to have_content("java@javamail.com")
      end
    end

    it 'cant add the same friend twice' do
      python = User.create!(email: "python@pythonmail.com", password: "potato", password_confirmation: "potato")
      ruby   = User.create(email: "ruby@gmail.com", password: "potato", password_confirmation: "potato")

      @user.friendships.create!(friend: python)

      visit current_path

      within '#friends' do
        fill_in('email', with: python.email)
        click_button('Add Friend')
      end

      expect(page).to have_content("Ya'll are already friends.")
    end

    it 'Shows all the details of a users parties' do
      python = User.create!(email: "python@pythonmail.com", password: "potato", password_confirmation: "potato")
      ruby   = User.create(email: "ruby@gmail.com", password: "potato", password_confirmation: "potato")
      @user.friendships.create!(friend: python)
      @user.friendships.create!(friend: ruby)
      party1 = @user.parties.create!(date: "2018-01-02 04:30:00 UST", movie_id: 1 )
      python.attendees.create!(party: party1, role: 1 )
      ruby.attendees.create!(party: party1, role: 1 )

      allow(party1).to receive(:movie_title).and_return("Star Wars")

      visit current_path


      within '#parties' do
        expect(page).to have_link("Star Wars")
        expect(page).to have_content("Tuesday, January 2, 2018 at 04:30AM")
        expect(page).to have_content("Hosting")
        expect(page).to have_content("Invited:")
        expect(page).to have_content(python.email)
        expect(page).to have_content(ruby.email)
      end
    end

    it 'shows the users name in bold for events they are not hosting' do
      python = User.create!(email: "python@pythonmail.com", password: "potato", password_confirmation: "potato")
      ruby   = User.create(email: "ruby@gmail.com", password: "potato", password_confirmation: "potato")
      ruby.friendships.create!(friend: @user)
      ruby.friendships.create!(friend: python)
      party1 = ruby.parties.create!(date: "2018-01-02 04:30:00 UST", movie_id: 1 )
      @user.attendees.create!(party: party1, role: 1 )
      python.attendees.create!(party: party1, role: 1 )


      @user.parties.reload
      ruby.parties.reload
      python.parties.reload

      allow(party1).to receive(:movie_title).and_return("Star Wars")
      # require "pry"; binding.pry
      visit current_path


      within '#parties' do
        expect(page).to have_link("Star Wars")
        expect(page).to have_selector('strong', text: @user.email)
      end
    end

  end
end
