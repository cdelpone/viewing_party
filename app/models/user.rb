class User < ApplicationRecord
  has_many :friendships
  has_many :attendees
  has_many :parties, through: :attendees

  validates :email, presence: true, uniqueness: true
  validates :password, confirmation: true
  validates :password_confirmation, presence: true, on: :create

  has_secure_password


  def self.search_by_email(email)
    where(email: email).first
  end
end
