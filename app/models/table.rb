class Table < ApplicationRecord
  has_many :reservations, dependent: :destroy
  validates :name, presence: true
  validates :seats, presence: true, inclusion: { in: 2..10 }
end
