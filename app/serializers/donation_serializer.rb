class DonationSerializer
  include JSONAPI::Serializer
  attributes :id, :harvest_date, :appointment_id
end