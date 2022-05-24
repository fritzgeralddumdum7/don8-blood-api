class BloodRequestSerializer
  include JSONAPI::Serializer
  attributes :code, :date_time, :user_id, :user, :case_id, :request_type_id, :blood_type_id, :is_closed, :organization, :blood_type, :request_type, :case

  attribute :total_appointments_made_per_request do |object|
    Appointment.where(
      :blood_request_id => object.id,
      :status => 1
    ).count
  end

  def organization
    object.organization.map do |d|
      ::OrganizationSerializer.new(d).attributes
    end
  end

  def blood_type
    object.blood_type.map do |d|
      ::BloodTypeSerializer.new(d).attributes
    end
  end

  def request_type
    object.request_type.map do |d|
      ::RequestTypeSerializer.new(d).attributes
    end
  end

  def case
    object.case.map do |d|
      ::CaseSerializer.new(d).attributes
    end
  end

  def user
    object.user.map do |d|
      ::UserSerializer.new(d).attributes
    end
  end
end
