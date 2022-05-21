module Api
  class BloodRequestsController < ApplicationController
    def index
      all_blood_requests = BloodRequest.find_by_sql(BloodRequest.apibody)        

      #Requests per blood type and with no appointments for the selected donor yet 
      if get_blood_type_id != nil && get_blood_type_id != 0 && get_user_id != nil && get_user_id != 0
        blood_requests = all_blood_requests.find_all{|obj| 
          obj.blood_type_id == get_blood_type_id && 
          obj.is_closed == false &&
          obj.donor_id == nil &&
          obj.status == 1
          }
      
      #Requests per city/municipality  
      elsif get_city_municipality_id != nil && get_city_municipality_id != 0
        blood_requests = all_blood_requests.find_all{|obj| obj.city_municipality_id == get_city_municipality_id}
      
      #Requests per organization
      elsif get_organization_id != nil && get_organization_id != 0
        blood_requests = all_blood_requests.find_all{|obj| obj.organization_id == get_organization_id && obj.status == 1}

      #All Requests   
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
      
      d = DateTime.now
      blood_request.code = d.strftime("%Y%m%d%H%M%s")
      
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

    def close
      bloodRequest = BloodRequest.find(params[:id])
      bloodRequest.update is_closed: true

      render json: {status: "Successful"}
    end

    def reOpen
      bloodRequest = BloodRequest.find(params[:id])
      bloodRequest.update is_closed: false

      render json: {status: "Successful"}
    end

    def cancel
      bloodRequest = BloodRequest.find(params[:id])
      bloodRequest.update status: 0

      render json: {status: "Successful"}
    end
  
    private

    def blood_request_params
        params.require(:blood_request).permit(:date_time, 
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

    def get_organization_id
      params[:organization_id].to_i
    end

    def get_user_id
      params[:user_id].to_i
    end

    def serialize_blood_request(id)
      blood_request = BloodRequest.select(@@query)
        .joins(:user,:case, :request_type, :blood_type)
        .joins(:organization => :city_municipality)
        .joins("LEFT JOIN appointments ON appointments.blood_request_id = blood_requests.id")
        .where(:id => id)

        BloodRequestSerializer.new(blood_request)
    end
  end
end