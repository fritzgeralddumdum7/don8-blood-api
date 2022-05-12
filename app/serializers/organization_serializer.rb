class OrganizationSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :organization_type_name, :city_municipality_name, :latitude, :longitude, :province_name
end