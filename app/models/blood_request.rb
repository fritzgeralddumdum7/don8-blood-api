class BloodRequest < ApplicationRecord
  belongs_to :user
  belongs_to :case
  belongs_to :organization
  belongs_to :request_type
  belongs_to :blood_type
  has_many :appointments
  validates :code, presence: true, uniqueness: true
  validates :date_time, presence: true

  def self.apibody
    "SELECT DISTINCT blood_requests.id,
    blood_requests.code,
    blood_requests.date_time,
    blood_requests.user_id,
    blood_requests.status,
    CONCAT(users.firstname, ' ', users.lastname) as patient_name,
    blood_requests.organization_id,
    organizations.name as organization_name,
    city_municipalities.name as city_municipality_name,
    cases.id as case_id,
    cases.name as case_name,
    request_types.id as request_type_id,
    request_types.name as request_type_name,
    blood_types.id as blood_type_id,
    blood_types.name as blood_type_name,
    blood_requests.is_closed,
    blood_requests.status,
    (SELECT COUNT(a.id) FROM appointments a WHERE a.blood_request_id = blood_requests.id AND a.status = 1) no_of_appointments
    FROM blood_requests
    INNER JOIN users ON users.id = blood_requests.user_id
    INNER JOIN cases ON cases.id = blood_requests.case_id
    INNER JOIN request_types ON request_types.id = blood_requests.request_type_id
    INNER JOIN blood_types ON blood_types.id = blood_requests.blood_type_id
    INNER JOIN organizations ON organizations.id = blood_requests.organization_id
    INNER JOIN city_municipalities ON city_municipalities.id = organizations.city_municipality_id
    INNER JOIN provinces ON provinces.id = city_municipalities.province_id"
  end

  def self.sort
    "ORDER BY blood_requests.is_closed, blood_requests.date_time"
  end

end
