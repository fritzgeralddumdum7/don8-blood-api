class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :blood_request
  has_many :donations

  def self.apibody
    "appointments.id,
    appointments.date_time,
    appointments.is_completed,
    blood_request_id as blood_request_id,
    blood_requests.code as blood_request_code,
    blood_types.name as blood_type_name,
    appointments.user_id,
    CONCAT(users.firstname, ' ', users.lastname) as donor_name,
    organizations.id as organization_id,
    organizations.name as organization_name,
    request_types.name as request_type_name,
    cases.name as case_name"
  end
end
