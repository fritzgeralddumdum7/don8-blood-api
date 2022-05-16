module Api
  class ProvincesController < ApplicationController
    skip_before_action :authenticate_user!
    
    def index
      provinces = Province.select("id, name as province_name")

      render json: ProvinceSerializer.new(provinces)
    end
  
    def show
    end
  end
end