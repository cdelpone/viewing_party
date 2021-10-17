require 'rails_helper'

RSpec.describe Party, type: :model do
  describe 'relationships' do
    it { should have_many(:attendees)}
  end

  describe 'valiations' do
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:time) }
  end

  describe 'instance methods' do
    before(:each) do
      @ruby   = User.create(email: "ruby@gmail.com", password: "potato", password_confirmation: "potato")
      @java   = User.create!(email: "java@javamail.com", password: "banana", password_confirmation: "banana")
      @python = User.create!(email: "python@pythonmail.com", password: "potato", password_confirmation: "potato")
      @yaml = User.create!(email: "yaml@yamlmail.com", password: "yam", password_confirmation: "yam")

      @sw = @ruby.parties.create!(date: "2018-01-02", time: "04:30:00 UST", movie_id: 1, movie_title: "Star Wars")
    end

    describe '#host?(user)' do
      it 'confirms if user is host' do
        @sw.attendees.create(user: @java, role: 1)

        expect(@sw.host?(@ruby)).to be_truthy
        expect(@sw.host?(@java)).to be_falsy
      end
    end

    describe '#host' do
      it 'returns the host' do
        @sw.attendees.create(user: @java, role: 1)

        expect(@sw.host).to     eq(@ruby)
        expect(@sw.host).to_not eq(@java)
      end
    end

    describe '#host_email' do
      it 'returns host email' do
        @sw.attendees.create(user: @java, role: 1)

        expect(@sw.host_email).to     eq(@ruby.email)
        expect(@sw.host_email).to_not eq(@java.email)
      end
    end

    describe '#invited_guests' do
      it 'returns invited guests excluding host' do
        @sw.attendees.create(user: @java, role: 1)

        expect(@sw.invited_guests).to eq([@java])
      end
    end

    describe '#invite_friends_by_ids(friend_ids)' do
      it 'adds friends as guests to the party attendees' do
        @sw.invite_friends_by_ids([@java.id, @python.id])

        expect(@sw.invited_guests).to eq([@java, @python])
      end
    end
  end
end
