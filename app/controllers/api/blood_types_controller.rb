module Api
  class BloodTypesController < ApplicationController
    def index
      render json: BloodTypeSerializer.new(BloodType.all)
    end

    def show
      blood_type = BloodType.find(params[:id])
      render json: BloodTypeSerializer.new(blood_type)
    end
  end
end
