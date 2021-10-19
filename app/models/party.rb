class Party < ApplicationRecord
  has_many :attendees, dependent: :destroy

  validates :date, presence: true
  validates :time, presence: true

  delegate :email, to: :host, prefix: true

  def host?(user)
    user == host
  end

  def host
    User.joins(:attendees)
        .where(attendees: { role: 0, party_id: id })
        .first
  end

  def invited_guests
    User.joins(:attendees)
        .where(attendees: { role: 1, party_id: id })
  end

  def invite_friends_by_ids(friend_ids)
    friend_ids.each do |id|
      attendees.create(user_id: id, role: 1)
    end
  end
end
