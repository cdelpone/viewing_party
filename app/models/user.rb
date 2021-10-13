class User < ApplicationRecord
  has_many :friendships
  has_many :attendees
  has_many :parties, through: :attendees
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  has_secure_password
end
