module Api
  class BloodRequestsController < ApplicationController
    def index
      all_blood_requests = BloodRequest.select("blood_requests.id,
        blood_requests.code,
        blood_requests.date_time,
        users.firstname as patient_name,
        organizations.name as organization_name,
        city_municipalities.id as city_municipality_id,
        city_municipalities.name as city_municipality_name,
        cases.name as case_name,
        request_types.name as request_type_name,
        blood_types.id as blood_type_id,
        blood_types.name as blood_type_name")
        .joins(:user,:case, :request_type, :blood_type)
        .joins(:organization => :city_municipality).uniq

      if get_blood_type_id != nil && get_blood_type_id != 0
        blood_requests = all_blood_requests.find_all{|obj| obj.blood_type_id == get_blood_type_id}
      
      elsif get_city_municipality_id != nil && get_city_municipality_id != 0
        blood_requests = all_blood_requests.find_all{|obj| obj.city_municipality_id == get_city_municipality_id}
      
      else
        blood_requests = all_blood_requests        
      end  
      
      options={}
      options[:meta] = {total: blood_requests.count}
      render json: BloodRequestSerializer.new(blood_requests)      
    end
  
    def show
      render json: serialize_blood_request(params[:id])
    end
  
    def create
      blood_request = BloodRequest.new(blood_request_params)
      
      if blood_request.save
        render json: serialize_blood_request(blood_request.id)
      else
        render json: {errors: blood_request.errors}
      end
    end
  
    def update
      blood_request = BloodRequest.find(params[:id])

      if blood_request.update(blood_request_params)
        render json: serialize_blood_request(blood_request.id)
      else
        render json: {errors: blood_request.errors}
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

    def get_city_municipality_id
      params[:city_municipality_id].to_i
    end

    def get_blood_type_id
      params[:blood_type_id].to_i
    end

    def serialize_blood_request(id)
      blood_request = BloodRequest.select("blood_requests.id,
        blood_requests.code,
        blood_requests.date_time,
        users.firstname as patient_name,
        organizations.name as organization_name,
        city_municipalities.name as city_municipality_name,
        cases.name as case_name,
        request_types.name as request_type_name,
        blood_types.name as blood_type_name")
        .joins(:user,:case, :request_type, :blood_type)
        .joins(:organization => :city_municipality)
        .where(:id => id)

        BloodRequestSerializer.new(blood_request)
    end
  end
end