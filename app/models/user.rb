class User < ApplicationRecord
  has_many :friendships, dependent: :destroy
  has_many :attendees,   dependent: :destroy
  has_many :friends, through: :friendships
  has_many :parties, through: :attendees

  validates :email, presence: true, uniqueness: true
  validates :password, confirmation: true
  validates :password_confirmation, presence: true, on: :create

  has_secure_password

  def self.search_by_email(email)
    where(email: email).first
  end
end
