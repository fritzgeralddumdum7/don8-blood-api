class BloodRequest < ApplicationRecord
  belongs_to :user
  belongs_to :case
  belongs_to :organization
  belongs_to :request_type
  belongs_to :blood_type
  has_many :appointments
  validates :code, presence: true, uniqueness: true
  validates :datetime, presence: true
end
