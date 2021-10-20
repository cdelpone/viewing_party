require 'rails_helper'

RSpec.describe 'Destroy session', type: :feature do
  before :each do
    @user = User.create!(email: "ruby@rubymail.com", password: "turing", password_confirmation: "turing")

    visit root_path

    fill_in :email, with: @user.email
    fill_in :password, with: @user.password

    click_button "Sign In"
  end

  describe 'dashboard page' do
    it 'can log out' do
      click_link 'Log Out'
      expect(current_path).to eq(root_path)

      visit dashboard_path
      expect(current_path).to eq(root_path)
      expect(page).to have_content("You shall not pass")
    end
  end
end
