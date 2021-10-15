require 'rails_helper'

RSpec.describe Attendee, type: :model do
  describe 'relationships' do
    it { should belong_to(:party) }
    it { should belong_to(:user) }
  end

  describe 'processes' do
    it { should define_enum_for(:role).with_values(["host", "guest"]) }

  end

  describe 'enum' do
    it 'sets the role to host as a default' do
      user = User.create!(email: "aeaf@gmail.com", password: "string", password_confirmation: "string")
      party1 = Party.create!(date: "2018-01-02 04:43:00 UST", movie_id: 1 )
      attendee1 = user.attendees.create!(party: party1)

      expect(attendee1.role).to eq("host")
    end
  end
end
