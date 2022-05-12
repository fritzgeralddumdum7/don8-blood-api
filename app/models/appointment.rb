class Appointment < ApplicationRecord
  # belongs_to :user
  belongs_to :blood_request
  has_many :donations
end
