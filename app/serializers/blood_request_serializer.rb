class BloodRequestSerializer
  include JSONAPI::Serializer
  attributes :code, :date_time, :user_id, :patient_name, :case_id, :case_name, :organization_name, :city_municipality_name, :request_type_id, :request_type_name, :blood_type_id, :blood_type_name, :is_closed
end
