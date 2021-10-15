class Party < ApplicationRecord
  has_many :attendees

  #This will not stay and is only here for the stub in dashboard index spec
  def movie_title

  end

  def host?(user)
    attendee = attendees.where(user_id: user.id).first
    attendee && attendee.role == "host"
  end

  def invited_guests
    attendees.joins(:user)
             .select('users.email, attendees.*')
             .where(role: 1)
  end
end
