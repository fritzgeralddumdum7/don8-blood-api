class CityMunicipality < ApplicationRecord
  belongs_to :province
  has_many :user
  validates :name, presence: true, uniqueness: true
end
