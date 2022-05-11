module Api
  class AppointmentsController < ApplicationController
    def index
      all_appointments = Appointment.select("appointments.id,
      appointments.date_time,
      blood_types.name as blood_type_name,
      appointments.user_id,
      CONCAT(users.firstname, ' ', users.lastname) as donor_name,
      organizations.id as organization_id,
      organizations.name as organization_name"
    ).joins(:blood_request => :blood_type)
    .joins(:blood_request => :organization)
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

      if appointment.save
        render json: appointment
      else
        render json: {errors: appointment.errors}
      end
    end
  
    def update
    end
  
    def destroy
    end

    private
    
    def appointment_params
      params.require(:appointment).permit(:date_time,
        :user_id,
        :blood_request_id,
        :is_completed,
        :status
      )
    end

    def get_user_id
      params[:user_id].to_i
    end

    def serialize_appointment(id)
      appointment = Appointment.select("appointments.id,
        appointments.date_time,
        blood_types.name as blood_type_name,
        appointments.user_id,
        CONCAT(users.firstname, ' ', users.lastname) as donor_name,
        organizations.name as organization_name"
      ).joins(:blood_request => :blood_type)
      .joins(:blood_request => :organization)
      .joins(:user)
      .where(:id => id)

      AppointmentSerializer.new(appointment)
    end
  end
end