class OrganizationSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :address, :organization_type_id, :city_municipality_id, :organization_type, :city_municipality

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

  # def province
  #   object.province.map do |d|
  #     ::ProvinceSerializer.new(d).attributes
  #   end
  # end

  # , :organization_type_name, :city_municipality_name, :province_name, :latitude, :longitude
end