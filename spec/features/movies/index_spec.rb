require 'rails_helper'

RSpec.describe 'movies index', type: :feature do
  describe 'invalid user' do
    before(:each) do
      visit movies_path
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

      visit movies_path
    end

    it 'lists 40 titles of top movies', :vcr do
      
    end
  end
end
