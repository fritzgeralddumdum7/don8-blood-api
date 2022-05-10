class CityMunitipalitySerializer
  include JSONAPI::Serializer
  attributes :id, :city_municipality_name, :province_name
end
