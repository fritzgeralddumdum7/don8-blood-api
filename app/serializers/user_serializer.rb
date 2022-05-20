class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :blood_type_id, :blood_type_name, :role
end
