class Reservation < ApplicationRecord
  MINIMUM_RESERVATION_TIME = 2.hours

  belongs_to :table
  validate :minimum_reservation_time_exceeded
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  def minimum_reservation_time_exceeded
    return false unless end_time && start
    (end_time - start) >  MINIMUM_RESERVATION_TIME
  end
end
