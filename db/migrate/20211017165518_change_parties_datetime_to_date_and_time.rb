class ChangePartiesDatetimeToDateAndTime < ActiveRecord::Migration[5.2]
  def change
    change_column :parties, :date, :date
    add_column    :parties, :time, :time
  end
end
