class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :car, dependent: :destroy

  validates :date, presence: true
  validates :location, presence: true
  validate :validate_date_format

  private

  def validate_date_format
    return if date.is_a?(Date) || date.is_a?(Time)

    errors.add(:date, 'must be a valid date')
  end
end
