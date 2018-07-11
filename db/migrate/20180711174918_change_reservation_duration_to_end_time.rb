class ChangeReservationDurationToEndTime < ActiveRecord::Migration[5.2]
  def change
    remove_column :reservations, :duration
    add_column :reservations, :end_time, :datetime
  end
end
