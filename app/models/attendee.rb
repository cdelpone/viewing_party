class Attendee < ApplicationRecord
  belongs_to :party
  belongs_to :user

  enum role: { host: 0, guest: 1 }
end
