require 'rails_helper'

RSpec.describe Party, type: :model do
  describe 'relationships' do
    it { should have_many(:attendees)}
  end

  describe 'instance methods' do
    before(:each) do
      @ruby   = User.create(email: "ruby@gmail.com", password: "potato", password_confirmation: "potato")
      @java   = User.create!(email: "java@javamail.com", password: "banana", password_confirmation: "banana")
      @python = User.create!(email: "python@pythonmail.com", password: "potato", password_confirmation: "potato")

      @sw = @ruby.parties.create!(date: "2018-01-02 04:30:00 UST", movie_id: 1, movie_title: "Star Wars")

      @java.attendees.create(party: @sw, role: 1)
    end

    describe '#host?(user)' do
      it 'confirms if user is host' do
        expect(@sw.host?(@ruby)).to be_truthy
        expect(@sw.host?(@java)).to be_falsy
      end
    end

    describe '#host' do
      it 'returns the host' do
        expect(@sw.host).to     eq(@ruby)
        expect(@sw.host).to_not eq(@java)
      end
    end

    describe '#host_email' do
      it 'returns host email' do
        expect(@sw.host_email).to     eq(@ruby.email)
        expect(@sw.host_email).to_not eq(@java.email)
      end
    end

    describe '#invited_guests' do
      it 'returns invited guests excluding host' do
        expectation = [@java]
        expect(@sw.invited_guests).to eq(expectation)
      end
    end
  end
end
