class Reservation < ApplicationRecord
  MINIMUM_RESERVATION_TIME = 2.hours

  belongs_to :table
  validate :minimum_reservation_time_exceeded

  def self.create_with_duration!(table:, party_size:, start:, duration:)
    end_time = start + duration.hours

    Reservation.create!(
      table: table,
      party_size: party_size,
      start: start,
      end_time: end_time
    )
  end

  def minimum_reservation_time_exceeded
    (end_time - start) >  MINIMUM_RESERVATION_TIME
  end
end
