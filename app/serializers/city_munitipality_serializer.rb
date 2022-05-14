class CityMunitipalitySerializer
  include JSONAPI::Serializer
  attributes :id, :name, :province_name
end
