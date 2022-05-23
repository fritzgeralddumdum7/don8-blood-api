module Api
    require 'bcrypt'
    require 'date'
    
    class UsersController < ApplicationController
        def index
            all_users = User.select("users.id,
              CONCAT(users.firstname,' ', users.lastname) as name,
              users.blood_type_id,
              blood_types.name as blood_type_name,
              role,
              city_municipalities.name as city_municipality_name,
              provinces.name as province_name")
              .joins(:blood_type)
              .left_outer_joins(:city_municipality => :province)
              .where(role: get_role)
      
            render json: UserSerializer.new(all_users)
        end
          
        def profile
            result = {
                data: current_user,
                city_municipality: current_user.city_municipality,
                blood_type: current_user.blood_type
            }
            
            if (current_user.role === 2)
                result = { **result, organization: current_user.organization }
            end

            render json: result
        end

        def validate_password
            is_matched = BCrypt::Password.new(current_user.encrypted_password) == params[:password]
            error = 'Password entered is incorrect' if !is_matched
            render json: { error: error }
        end

        def update_password
            user = User.find(current_user.id)
            user.encrypted_password = BCrypt::Password.create(user_params[:new_password])
            user.save!
            render json: { message: 'Password updated successfully' }
        end

        def dashboard
            result = Hash.new
            if current_user.role == 1
                result = donor_dashboard
            elsif current_user.role == 2
                result = org_dashboard
            end

            render json: { data: result }
        end

        private

        def get_role
            params[:role].to_i
        end

        def user_params
            params.require(:user).permit(
                :new_password,
                :password
            )
        end

        def patients_helped(flag)
            Appointment.where(
                :user_id => current_user.id,
                :is_completed => flag,
                :status => 1
            )
        end

        def org_patients(flag)
            Appointment
                .joins(:blood_request)
                .where(
                    blood_request: { :organization_id => current_user.organization_id },
                    :is_completed => flag,
                    :status => 1
                )
        end

        def cases_per_month_stats
            cases = []
            today = DateTime.now

            Case.all.each do |_case|
                stats = []

                for m in (0...12).to_a.reverse do
                    start_date = today.prev_month(m).strftime("%Y-%m-1 00:00:000")
                    end_date = today.prev_month(m).strftime("%Y-%m-#{today.prev_month(m).end_of_month.strftime("%d")} 00:00:000")
                    total = BloodRequest.where(["created_at >= ? AND created_at <= ? AND case_id = ?", start_date, end_date, _case.id]).count
                    stats << total
                end

                cases << {
                    label: _case.name,
                    data: stats
                }
            end
            cases
        end

        def donor_dashboard
            next_appointment = nil
            result = Hash.new
            total_requests = BloodRequest
                .where(
                    :blood_type_id => current_user.blood_type_id,
                    :status => 1
                ).count
            next_appointment = patients_helped(false).order(date_time: :desc).first
            orgs_near_me = BloodRequest
                .joins(:organization => :city_municipality)
                .where(organization: { city_municipality_id: current_user.city_municipality_id }
                ).distinct.count(:organization_id)

            orgs = Organization.all.count
            orgs = []
            Organization.all.each do |org|
                available_requests = BloodRequest
                    .joins(:organization)
                    .where(
                        :is_closed => false,
                        :status => 1,
                        :organization_id => org.id
                    ).count

                total_patients_helped_in_org = Appointment
                    .joins(:blood_request => :organization)
                    .where(
                        :user_id => current_user.id,
                        :is_completed => true,
                        blood_request: { organization_id: org.id }
                    )

                orgs << {
                    name: org.name,
                    address: org.address,
                    available_requests: available_requests,
                    patients_helped: total_patients_helped_in_org.count,
                    last_donation: total_patients_helped_in_org.present? ? total_patients_helped_in_org.last : nil
                }
            end

            if next_appointment.present?
                next_appointment = {
                    organization_name: next_appointment.blood_request.organization.name,
                    schedule: next_appointment.date_time
                }
            end

            result = {
                total_requests: total_requests,
                pending_appointments: patients_helped(false).count,
                patients_helped: patients_helped(true).count,
                next_appointment: ,
                orgs_near_me: orgs_near_me,
                case_stats: cases_per_month_stats,
                orgs: orgs
            }

            result
        end

        def org_dashboard
            next_appointment = nil
            result = Hash.new
            total_requests = BloodRequest
                .where(:organization_id => current_user.organization_id).count
            next_appointment = org_patients(false).order(date_time: :desc).first

            orgs = Organization.all.count
            orgs = []
            Organization.all.each do |org|
                available_requests = BloodRequest
                    .joins(:organization)
                    .where(
                        :is_closed => false,
                        :status => 1,
                        :organization_id => org.id
                    ).count

                total_patients_helped_in_org = Appointment
                    .joins(:blood_request => :organization)
                    .where(
                        :user_id => current_user.id,
                        :is_completed => true,
                        blood_request: { organization_id: org.id }
                    )

                orgs << {
                    name: org.name,
                    address: org.address,
                    available_requests: available_requests,
                    patients_helped: total_patients_helped_in_org.count,
                    last_donation: total_patients_helped_in_org.present? ? total_patients_helped_in_org.last : nil
                }
            end

            total_patients = User.where(:role => 3).count

            if next_appointment.present?
                next_appointment = {
                    organization_name: "#{next_appointment.user.firstname} #{next_appointment.user.lastname}",
                    schedule: next_appointment.date_time
                }
            end

            result = {
                total_requests: total_requests,
                pending_appointments: org_patients(false).count,
                patients_helped: org_patients(true).count,
                next_appointment: next_appointment,
                total_patients: total_patients,
                case_stats: cases_per_month_stats,
                orgs: orgs
            }

            result
        end
    end
end
