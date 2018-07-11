class Table < ApplicationRecord
  validates :seats, presence: true, inclusion: { in: 2..10 }
end
