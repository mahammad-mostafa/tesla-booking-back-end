class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :car, dependent: :destroy

  validates :date, presence: true
  validates :city, presence: true
end
