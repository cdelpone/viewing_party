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
    expect(current_path).to eq(dashboard_path)
  end

   it 'doesnt allow wrong info' do
     email = "example@email.com"
     password = ""
     fill_in 'user[email]', with: email
     fill_in 'user[password]', with: password
     fill_in 'user[password_confirmation]', with: password
     click_button "Create Account"
     expect(current_path).to eq(new_user_path)
     expect(page).to have_content("There's an issue with your information.")

   end
end
