module Api
  class BloodTypesController < ApplicationController
    def index
      render json: BloodType.all
    end

    def show
      blood_type = BloodType.find(params[:id])
      render json: blood_type
    end
  end
end
