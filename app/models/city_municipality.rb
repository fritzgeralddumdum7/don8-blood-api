class CityMunicipality < ApplicationRecord
  belongs_to :province
  belongs_to :user
  has_one :user
  validates :name, presence: true, uniqueness: true
end
