class Organization < ApplicationRecord
  belongs_to :city_municipality
  has_many :blood_requests
  validates :name, presence: true, uniqueness: true
  validates :address, presence: true
end
