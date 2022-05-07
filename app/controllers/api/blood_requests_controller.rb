module Api
  class BloodRequestsController < ApplicationController
    def index
      render json: BloodRequest.all
    end
  
    def show
      @blood_request = BloodRequest.find(params[:id])
      render json: @blood_request
    end
  
    def create
      @blood_request = BloodRequest.new(blood_request_params)
      
      if @blood_request.save
        render json: @blood_request
      else
        render json: @blood_request.errors
      end
    end
  
    def update
      @blood_request = BloodRequest.find(params[:id])

      if @blood_request.update(blood_request_params)
        render json: @blood_request
      else
        render json: @blood_request.errors
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