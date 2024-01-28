class Car < ApplicationRecord
  belongs_to :user
  has_many :performance_details, dependent: :destroy
end
