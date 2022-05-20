class AppointmentSerializer
  include JSONAPI::Serializer
  attributes :date_time, :is_completed, :blood_request_id, :blood_request_code, :blood_type_name, :user_id, :donor_name, :organization_name, :request_type_name, :case_name
end
