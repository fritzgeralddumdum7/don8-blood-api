class OrganizationSerializer
  include JSONAPI::Serializer
  attributes :id, :organization_name, :organization_type_name, :city_municipality_id, :city_municipality_name, :latitude, :longitude
end
