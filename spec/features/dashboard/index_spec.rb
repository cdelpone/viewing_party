require 'rails_helper'

RSpec.describe 'dashboard' do
  it 'is not accessible without logging in' do
    visit dashboard_path

    expect(current_path).to eq(root_path)
    expect(page).to have_content("You shall not pass")
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
      # click_button "Discover Movies"
      # expect(current_path).to eq(discover_path)
    end

    it 'has sections for friends and parties' do
      within '#friends' do
        expect(page).to have_content('Friends')
      end
      
      within '#parties' do
        expect(page).to have_content('Parties')
      end
    end
  end
end
