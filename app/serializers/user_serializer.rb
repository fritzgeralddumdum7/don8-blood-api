class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :blood_type_id, :blood_type, :role, :city_municipality

  attribute :name do |object|
    "#{object.firstname} #{object.lastname}"
  end

  attribute :province do |object|
    ::ProvinceSerializer.new(object.city_municipality.province)
  end

  def blood_type
    object.blood_type.map do |d|
      ::BloodTypeSerializer.new(d).attributes
    end
  end

  def city_municipality
    object.city_municipality.map do |d|
      ::CityMunicipalitySerializer.new(d).attributes
    end
  end
end
