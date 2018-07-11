class Reservation < ApplicationRecord
  MINIMUM_RESERVATION_TIME = 2.hours

  belongs_to :table
  validate :minimum_reservation_time_exceeded

  def minimum_reservation_time_exceeded
    (end_time - start) >  MINIMUM_RESERVATION_TIME
  end
end
