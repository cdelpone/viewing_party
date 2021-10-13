require 'rails_helper'

RSpec.describe 'welcome page' do
  before :each do
    visit root_path
  end

  it 'welcomes the user' do
    expect(page).to have_content("Welcome to Viewing Party!")
    expect(page).to have_button("Sign In")
    expect(page).to have_link('New to Viewing Party? Register Here')
  end

  it 'takes a user to the registration form' do
    click_link("New to Viewing Party? Register Here")
    expect(current_path).to eq(new_user_path)
  end 
end
