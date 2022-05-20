module Api
  class AppointmentsController < ApplicationController
   def index
      all_appointments = Appointment.select(Appointment.apibody)
      .joins(:blood_request => :blood_type)
      .joins(:blood_request => :organization)
      .joins(:blood_request => :request_type)
      .joins(:blood_request => :case)
      .joins(:user).uniq
      
      # Completed Appointments per User
      if get_user_id != nil && get_user_id != 0 && get_is_completed != nil && get_is_completed != 0
      appointments = all_appointments.find_all{|obj| obj.user_id == get_user_id && obj.is_completed == get_is_completed }

      # Completed Appointments per Org
      elsif get_organization_id !=nil && get_organization_id !=0 && get_is_completed != nil && get_is_completed != 0
        appointments = all_appointments.find_all{|obj| obj.organization_id == get_organization_id && obj.is_completed == get_is_completed }
      
      # All Appointments per user/donor
      elsif get_user_id != nil && get_user_id != 0
        appointments = all_appointments.find_all{|obj| obj.user_id == get_user_id }

      #All Appointments per org
      elsif get_organization_id !=nil && get_organization_id !=0
        appointments = all_appointments.find_all{|obj| obj.organization_id == get_organization_id }
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

    def get_organization_id
      params[:organization_id].to_i
    end

    def get_is_completed
      params[:is_completed].nil? ? nil : to_boolean(params[:is_completed])
    end

    def serialize_appointment(id)
      appointment = Appointment.select(Appointment.apibody)
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