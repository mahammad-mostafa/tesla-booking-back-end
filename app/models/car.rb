class Car < ApplicationRecord
  belongs_to :user
  has_many :performance_details, dependent: :destroy
  has_many :reservations, dependent: :destroy

  accepts_nested_attributes_for :performance_details, allow_destroy: true

  validates :model_name, presence: true
  validates :image, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp }
  validates :description, presence: true
  validates :rental_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
