class AddDurationToParties < ActiveRecord::Migration[5.2]
  def change
    add_column :parties, :duration, :integer
    add_timestamps :parties
  end
end
