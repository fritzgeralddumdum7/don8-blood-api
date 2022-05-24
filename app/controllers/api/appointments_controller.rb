module Api
  class AppointmentsController < ApplicationController
   def index
      # All Appointments of Donor
      if get_transaction_type == 'allappointments_of_donor'
        appointments = Appointment.find_by_sql(Appointment.apibody + ' ' +
        'WHERE appointments.user_id = ' + get_user_id.to_s + ' AND ' +
        'appointments.status = 1 '
        )
        
        if params[:keyword] != nil
          appointments = appointments.find_all{|obj|
            (obj.organization_name.upcase.include? params[:keyword].upcase) || (obj.blood_request_code.include?(params[:keyword]))
          }
        end

      #All Appointments per org
      elsif get_transaction_type == 'allappointments_of_org'
        appointments = Appointment.find_by_sql(Appointment.apibody + ' ' +
        'WHERE blood_requests.organization_id = ' + get_organization_id.to_s + 'AND ' +
        'appointments.status = 1 '
        )    
        
        if params[:keyword] != nil
          appointments = appointments.find_all{|obj|
            (obj.donor_name.upcase.include? params[:keyword].upcase) || (obj.blood_request_code.include?(params[:keyword]))
          }
        end
      
      #All Appointments of specific blood request
      elsif get_transaction_type == 'allappointments_of_bloodrequest'
        appointments = Appointment.find_by_sql(Appointment.apibody + ' ' +
        'WHERE blood_requests.organization_id = ' + get_organization_id.to_s + ' AND ' +
        'blood_requests.id = ' + params[:blood_request_id] + ' AND ' +
        'appointments.status = 1 ' +
        Appointment.sort
        )    
        
        if params[:keyword] != nil
          appointments = appointments.find_all{|obj|
            (obj.donor_name.upcase.include? params[:keyword].upcase) || (obj.blood_request_code.include?(params[:keyword]))
          }
        end

      else
        appointments = all_appointments
      end

      ids = appointments.map(&:id)
      appointments = Appointment.where(id: ids).order(:is_completed, :date_time)

      options={}
      options[:meta] = {total: appointments.count}
      render json: {
        **AppointmentSerializer.new(appointments.page(params[:page] || 1), options),
        total_page: appointments.page(1).total_pages
      }
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
      appointment = Appointment.find_by_sql(Appointment.apibody).find_all{|obj| obj.id == id.to_i}

      AppointmentSerializer.new(appointment)
    end
  end
end