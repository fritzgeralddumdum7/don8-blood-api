class CityMunicipality < ApplicationRecord
  belongs_to :province
  validates :name, presence: true, uniqueness: true
end
