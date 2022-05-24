class OrganizationSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :address, :organization_type_id, :city_municipality_id, :organization_type, :city_municipality, :province

  attribute :province do |object|
    ::ProvinceSerializer.new(object.city_municipality.province)
  end

  def organization_type
    object.organization_type.map do |d|
      ::OrganizationTypeSerializer.new(d).attributes
    end
  end

  def city_municipality
    object.city_municipality.map do |d|
      ::CityMunicipalitySerializer.new(d).attributes
    end
  end
end