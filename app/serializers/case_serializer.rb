class CaseSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :description
end
