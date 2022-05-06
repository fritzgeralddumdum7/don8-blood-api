class BloodType < ApplicationRecord
    has_many :blood_requests
    validates :name, presence: true, uniqueness: true
end
