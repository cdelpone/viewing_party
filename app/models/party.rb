class Party < ApplicationRecord
  has_many :attendees

  validates_presence_of :date
  validates_presence_of :time

  def host?(user)
    user == host
  end

  def host
    User.joins(:attendees)
        .where(attendees: {role: 0, party_id: self.id})
        .first
  end

  def host_email
    host.email
  end

  def invited_guests
    User.joins(:attendees)
        .where(attendees: {role: 1, party_id: self.id})
  end

  def invite_friends_by_ids(friend_ids)
    friend_ids.each do |id|
      attendees.create(user_id: id, role: 1)
    end
  end
end
