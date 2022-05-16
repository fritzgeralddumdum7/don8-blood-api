module Api
  class OrganizationsController < ApplicationController
    skip_before_action :authenticate_user!
    
    @@query = "organizations.id,
    organizations.name,
    organization_types.id as organization_type_id,
    organization_types.name as organization_type_name,
    city_municipalities.id as city_municipality_id,
    city_municipalities.name as city_municipality_name,
    city_municipalities.latitude,
    city_municipalities.longitude,
    provinces.name as province_name"

    def index
      all_organizations = Organization.select(@@query)
      .joins(:organization_type)
      .joins(:city_municipality => :province).uniq
        
      if get_city_municipality_id == nil || get_city_municipality_id == 0
        organizations = all_organizations      
      else
        organizations = all_organizations.find_all { |obj| obj.city_municipality_id == get_city_municipality_id }
      end

      options={}
      options[:meta] = {total: organizations.count}
      render json: OrganizationSerializer.new(organizations, options)
    end
  
    def show
      render json: serialize_organization(params[:id])
    end
  
    def create
      organization = Organization.new(organization_params)
      
      if organization.save
        render json: serialize_organization(organization.id)
      else
        render json: {errors: organization.errors }
      end
      
    end
  
    def update
      organization = Organization.find(params[:id])

      if organization.update(organization_params)
        render json: serialize_organization(organization.id)
      else
        render json: {errors: organization.errors}
      end
    end
  
    def destroy

    end

    private

    def organization_params
        params.require(:organization).permit(:name, 
          :address, 
          :city_municipality_id, 
          :organization_type_id)
    end

    def get_city_municipality_id
      params[:city_municipality_id].to_i
    end

    def serialize_organization(id)
      organization = Organization.select(@@query)
      .joins(:organization_type)
      .joins(:city_municipality => :province)
      .where(:id => id)
      
      OrganizationSerializer.new(organization)
    end

  end
end