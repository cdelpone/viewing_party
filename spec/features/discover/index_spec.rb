require 'rails_helper'

RSpec.describe 'discover index', type: :feature do
  describe 'invalid user' do
    it 'is not accessible without logging in' do
      visit discover_path
      expect(current_path).to eq(root_path)
      expect(page).to have_content("You shall not pass")
    end
  end
end
