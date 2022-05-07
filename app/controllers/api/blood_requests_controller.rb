module Api
  class BloodRequestsController < ApplicationController
    def index
      blood_requests = BloodRequest.joins(:user,:case, :request_type, :blood_type).joins(:organization => :city_municipality).select("blood_requests.id,
        blood_requests.code,
        blood_requests.date_time,
        users.firstname as patient_name,
        organizations.name as organization_name,
        city_municipalities.name as city_municipality_name,
        cases.name as case_name,
        request_types.name as request_type_name,
        blood_types.name as blood_type_name").uniq

      render json: BloodRequestSerializer.new(blood_requests)
    end
  
    def show
      blood_request = BloodRequest.find(params[:id])
      render json: blood_request
    end
  
    def create
      blood_request = BloodRequest.new(blood_request_params)
      
      if blood_request.save
        render json: blood_request
      else
        render json: blood_request.errors
      end
    end
  
    def update
      blood_request = BloodRequest.find(params[:id])

      if blood_request.update(blood_request_params)
        render json: blood_request
      else
        render json: blood_request.errors
      end
    end
  
    def destroy
    end

    private

    def blood_request_params
        params.require(:blood_request).permit(:code, 
                                            :date_time, 
                                            :user_id, 
                                            :case_id, 
                                            :organization_id, 
                                            :request_type_id, 
                                            :blood_type_id )
    end
  end
end