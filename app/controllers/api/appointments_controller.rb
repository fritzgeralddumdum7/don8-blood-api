module Api
  class AppointmentsController < ApplicationController
    @@query = "appointments.id,
    appointments.date_time,
    appointments.is_completed,
    blood_request_id as blood_request_id,
    blood_requests.code as blood_request_code,
    blood_types.name as blood_type_name,
    appointments.user_id,
    CONCAT(users.firstname, ' ', users.lastname) as donor_name,
    organizations.id as organization_id,
    organizations.name as organization_name,
    request_types.name as request_type_name,
    cases.name as case_name"

    def index
      all_appointments = Appointment.select(@@query)
      .joins(:blood_request => :blood_type)
      .joins(:blood_request => :organization)
      .joins(:blood_request => :request_type)
      .joins(:blood_request => :case)
      .joins(:user).uniq
         
      if get_user_id != nil && get_user_id != 0
        appointments = all_appointments.find_all{|obj| obj.user_id == get_user_id }
      else
        appointments = all_appointments
      end

      options={}
      options[:meta] = {total: appointments.count}
      render json: AppointmentSerializer.new(appointments, options)
    end
  
    def show
      render json: serialize_appointment(params[:id])
    end
  
    def create
      appointment = Appointment.new(appointment_params)
      appointment.is_completed = false
      appointment.status = 1

      if appointment.save
        render json: appointment
      else
        render json: {errors: appointment.errors}
      end
    end
  
    def update
      appointment = Appointment.find(params[:id])

      if appointment.update(appointment_params)
        render json: serialize_appointment(appointment.id)
      else
        render json: {errors: appointment.errors}
      end
    end
  
    def complete
      appointment = Appointment.find(params[:id])
      appointment.update is_completed: true
    end

    def destroy
    end

    private
    
    def appointment_params
      params.require(:appointment).permit(:date_time,
        :user_id,
        :blood_request_id        
      )
    end

    def get_user_id
      params[:user_id].to_i
    end

    def serialize_appointment(id)
      appointment = Appointment.select(@@query)
      .joins(:blood_request => :blood_type)
      .joins(:blood_request => :organization)
      .joins(:blood_request => :request_type)
      .joins(:blood_request => :case)
      .joins(:user)
      .where(:id => id)

      AppointmentSerializer.new(appointment)
    end
  end
end