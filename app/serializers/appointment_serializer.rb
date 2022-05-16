class AppointmentSerializer
  include JSONAPI::Serializer
  attributes :date_time, :blood_type_name, :user_id, :donor_name, :organization_name, :request_type_name, :case_name, :blood_request_id
end
