module Api
  class AppointmentsController < ApplicationController
   def index
      all_appointments = Appointment.select(Appointment.apibody)
      .joins(:blood_request => :blood_type)
      .joins(:blood_request => :organization)
      .joins(:blood_request => :request_type)
      .joins(:blood_request => :case)
      .joins(:user).uniq
      
      # Completed Appointments of Donor
      if get_transaction_type == 'completedappointments_of_donor'
        appointments = all_appointments.find_all{|obj|
          obj.user_id == get_user_id &&
          obj.is_completed == true }
      
      # Completed Appointments of Org
      elsif get_transaction_type == 'completedappointments_of_org'
        appointments = all_appointments.find_all{|obj|
          obj.organization_id == get_organization_id &&
          obj.is_completed == true }
      
      # All Appointments of Donor
      elsif get_transaction_type == 'allappointments_of_donor'
        appointments = all_appointments.find_all{|obj|
          obj.user_id == get_user_id && obj.status == 1
        }

      #All Appointments per org
      elsif get_transaction_type == 'allappointments_of_org'
        appointments = all_appointments.find_all{|obj|
          obj.organization_id == get_organization_id && obj.status == 1
        }

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

    def cancel
      appointment = Appointment.find(params[:id])
      appointment.update status: 0
    end

    private
    
    def appointment_params
      params.require(:appointment).permit(:date_time,
        :user_id,
        :blood_request_id        
      )
    end

    def get_transaction_type
      params[:transaction_type]
    end

    def get_user_id
      current_user.id
    end

    def get_organization_id
      current_user.organization_id
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