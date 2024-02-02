class PerformanceDetail < ApplicationRecord
  belongs_to :car

  validates :detail, presence: true
end
