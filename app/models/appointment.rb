class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :blood_request
  has_many :donations

  def self.apibody
    "SELECT appointments.id,
    appointments.date_time,
    appointments.is_completed,
    appointments.status,
    blood_request_id as blood_request_id,
    blood_requests.code as blood_request_code,
    blood_types.name as blood_type_name,
    appointments.user_id,
    CONCAT(users.firstname, ' ', users.lastname) as donor_name,
    organizations.id as organization_id,
    organizations.name as organization_name,
    request_types.name as request_type_name,
    cases.name as case_name
    FROM appointments
    INNER JOIN blood_requests ON blood_requests.id = appointments.blood_request_id
    INNER JOIN blood_types ON blood_types.id = blood_requests.blood_type_id
    INNER JOIN organizations ON organizations.id = blood_requests.organization_id
    INNER JOIN request_types ON request_types.id = blood_requests.request_type_id
    INNER JOIN cases ON cases.id = blood_requests.case_id
    INNER JOIN users ON users.id = appointments.user_id"
  end

  def self.sort
    "ORDER BY appointments.is_completed, appointments.date_time"
  end
end
