require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many(:friendships) }
    it { should have_many(:attendees) }
    it { should have_many(:friends).through(:friendships)}
    it { should have_many(:parties).through(:attendees)}
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:password_confirmation) }
    it { should validate_confirmation_of(:password).on(:create)}
  end

  describe 'class methods' do
    describe 'search by email' do
      it 'can search by email' do
        python = User.create!(email: "python@pythonmail.com", password: "potato", password_confirmation: "potato")
        java   = User.create!(email: "java@javamail.com", password: "banana", password_confirmation: "banana")
        user = User.search_by_email(python.email)

        expect(user).to eq(python)
      end
    end

    describe 'friends' do
      it 'can collect friends' do
        user  = User.create!(email: "user@usermail.com", password: "coffee", password_confirmation: "coffee")
        python = User.create!(email: "python@pythonmail.com", password: "potato", password_confirmation: "potato")
        java   = User.create!(email: "java@javamail.com", password: "banana", password_confirmation: "banana")
        ruby   = User.create(email: "ruby@gmail.com", password: "potato", password_confirmation: "potato")

        user.friendships.create(friend: python)
        user.friendships.create(friend: java)

        python.friendships.create(friend: user)

        ruby.friendships.create(friend: user)
        ruby.friendships.create(friend: java)

        expect(user.friends).to eq([python, java])
        expect(python.friends).to eq([user])
        expect(ruby.friends).to eq([user, java])
      end
    end
  end
end
