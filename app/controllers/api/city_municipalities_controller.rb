module Api
  class CityMunicipalitiesController < ApplicationController
    def index
      all_cities_municipalities = CityMunicipality.select("city_municipalities.id,
      city_municipalities.name as city_municipality_name,
      provinces.id as province_id,
      provinces.name as province_name").joins(:province).uniq
     
      if get_province_id == nil || get_province_id == 0
        city_municipalities = all_cities_municipalities
      else
        city_municipalities = all_cities_municipalities.find_all{ |obj| obj.province_id == get_province_id }
      end 

      options={}
      options[:meta] = {total: city_municipalities.count}
      render json: CityMunitipalitySerializer.new(city_municipalities, options)
    end
  
    def show
      render json: serialize_city_municipality(params[:id])
    end

    private
    
    def get_province_id
      params[:province_id].to_i
    end

    def serialize_city_municipality(id)
      city_municipality = CityMunicipality.select("city_municipalities.id,
      city_municipalities.name as city_municipality_name,
      provinces.id as province_id,
      provinces.name as province_name").joins(:province).where(:id => id)

      CityMunitipalitySerializer.new(city_municipality)
    end   

  end  
end