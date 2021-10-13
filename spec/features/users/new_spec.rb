require 'rails_helper'

RSpec.describe 'Users New' do
  before :each do
    visit new_user_path
  end

  it 'has a form to create a new user' do
    email = "example@email.com"
    password = "Test"
    fill_in 'user[email]', with: email
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password
    click_button "Create Account"
    # expect(page).to have_content("Welcome, #{email}!")
    expect(current_path).to eq(dashboard_index_path)
  end
end
