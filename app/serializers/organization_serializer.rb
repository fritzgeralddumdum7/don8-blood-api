class OrganizationSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :address, :organization_type_id, :organization_type_name, :city_municipality_id, :city_municipality_name, :latitude, :longitude, :province_name
end