class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.references :tables, foreign_key: true
      t.datetime :start
      t.integer :duration

      t.timestamps
    end
  end
end
