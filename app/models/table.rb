class Table < ApplicationRecord
  has_many :reservations, dependent: :destroy
  validates :name, presence: true
  validates :seats, presence: true, inclusion: { in: 2..10 }

  def self.select_smallest_available(party_size:, start:, duration:)
    end_time = start + duration.hours

    Table.where('seats >= ?', party_size)
         .order('seats ASC')
         .left_outer_joins(:reservations)
         .where.not('reservations.start IS NOT NULL AND reservations.start BETWEEN ? and ?', start, end_time)
         .where.not('reservations.start IS NOT NULL AND reservations.end_time BETWEEN ? and ?', start, end_time)
         .first
  end
end
