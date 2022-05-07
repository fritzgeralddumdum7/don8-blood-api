module Api
  class CityMunicipalitiesController < ApplicationController
    def index
      @city_municipalities = CityMunicipality.joins(:province).select("city_municipalities.id,
        city_municipalities.name as city_municipality_name,
        provinces.name as province_name").uniq
      
      render json: CityMunitipalitySerializer.new(@city_municipalities)
    end
  
    def show
    end
  end  
end