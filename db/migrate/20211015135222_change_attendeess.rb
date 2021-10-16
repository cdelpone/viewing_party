class ChangeAttendeess < ActiveRecord::Migration[5.2]
  def change
    remove_column :attendees, :role
    add_column :attendees, :role, :integer, default: 0
  end
end
