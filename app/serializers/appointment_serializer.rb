class AppointmentSerializer
  include JSONAPI::Serializer
  attributes :date_time, :blood_type_name, :donor_name, :organization_name, :request_type_name, :case_name
end
