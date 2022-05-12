class BloodRequestSerializer
  include JSONAPI::Serializer
  attributes :code, :date_time, :patient_name, :case_name, :organization_name, :city_municipality_name, :request_type_name, :blood_type_name
end
