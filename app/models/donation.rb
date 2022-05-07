class Donation < ApplicationRecord
  belongs_to :appointment
  validates :harvest_date, presence: true
end
