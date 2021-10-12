require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many(:friends) }
    it { should have_many(:attendees) }
  end
end
