class Table < ApplicationRecord
  has_many :reservations, dependent: :destroy
  validates :name, presence: true
  validates :seats, presence: true, inclusion: { in: 2..10 }

  def self.select_smallest_available(reservation)
    Table.where('seats >= ?', reservation.party_size)
         .order('seats ASC')
         .left_joins(:reservations)
         .find { |table| table.is_available?(start: reservation.start, end_time: reservation.end_time) }
  end

  def is_available?(start:, end_time:)
    return true if reservations.count == 0

    reservations
    .where('reservations.start < ? AND reservations.end_time > ?', end_time, start)
    .empty?
  end
end
