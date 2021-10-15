class Party < ApplicationRecord
  has_many :attendees

  def host?(user)
    attendee = attendees.where(user_id: user.id).first
    attendee && attendee.role == "host"
  end

  def host
    attendees.joins(:user)
             .select('users.email')
             .where(role: 0)
             .first
  end

  def host_email
    host.email
  end

  def invited_guests
    attendees.joins(:user)
             .select('users.email, attendees.*')
             .where(role: 1)
  end
end
