class Province < ApplicationRecord
    has_many :city_municipalities
    validates :name, presence: true, uniqueness: true
end
