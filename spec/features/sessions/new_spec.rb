require 'rails_helper'

RSpec.describe 'New Session' do
  before :each do
    @user = User.create!(email: "ruby@rubymail.com", password: "turing", password_confirmation: "turing")

    visit root_path
  end

  it 'can log in with valid credentials' do
    fill_in :email, with: @user.email
    fill_in :password, with: @user.password

    click_button "Sign In"

    expect(current_path).to eq(dashboard_path)
  end

   it 'cannot log in with invalid credentials' do
    fill_in :email, with: 'skjdgfhdfklg'
    fill_in :password, with: @user.password

    click_button "Sign In"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Sorry, your credentials are bad.")

    fill_in :email, with: @user.email
    fill_in :password, with: 'kdhfgf sdh'

    click_button "Sign In"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Sorry, your credentials are bad.")
  end
end
