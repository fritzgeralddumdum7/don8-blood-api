class AppointmentSerializer
  include JSONAPI::Serializer
  attributes :date_time, :is_completed, :blood_request_id, :blood_request, :user_id, :user
  attribute :organization do |object|
    ::OrganizationSerializer.new(object.blood_request.organization)
  end
  attribute :blood_type do |object|
    ::BloodTypeSerializer.new(object.blood_request.blood_type)
  end
  attribute :request_type do |object|
    ::RequestTypeSerializer.new(object.blood_request.request_type)
  end
  attribute :case do |object|
    ::CaseSerializer.new(object.blood_request.case)
  end

  def blood_request
    object.blood_request.map do |d|
      ::BloodRequestSerializer.new(d).attributes
    end
  end

  def user
    object.user.map do |d|
      ::UserSerializer.new(d).attributes
    end
  end
end
