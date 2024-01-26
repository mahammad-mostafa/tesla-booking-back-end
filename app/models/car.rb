class Car < ApplicationRecord
  belongs_to :user
  has_many :performance_details, dependent: :destroy
  has_many :reservations, dependent: :destroy
  
  accepts_nested_attributes_for :performance_details, allow_destroy: true
end
