module Api
  class OrganizationsController < ApplicationController
    before_action :set_city_municipality, only: %i[index]

    def index
      all_organizations = Organization.joins(:organization_type, :city_municipality).select("organizations.id,
        organizations.name as organization_name,
        organization_types.name as organization_type_name,
        city_municipalities.id as city_municipality_id,
        city_municipalities.name as city_municipality_name,
        city_municipalities.latitude,
        city_municipalities.longitude").uniq

      if set_city_municipality == nil
        organizations = all_organizations      
      else
        all_organizations.where("city_municipality_id=?",set_city_municipality).all
      end

      options={}
      options[:meta] = {total: Organization.count}
      render json:  OrganizationSerializer.new(organizations, options)
    end
  
    def show
      organization = Organization.find(params[:id])
      render json: organization
    end
  
    def create
      organization = Organization.new(organization_params)
      
      if organization.save
        render json: organization
      else
        render json: organization.errors
      end
      
    end
  
    def update
      organization = Organization.find(params[:id])

      if organization.update(organization_params)
        render json: organization
      else
        render json: organization.errors
      end
    end
  
    def destroy
    end

    private

    def organization_params
        params.require(:organization).permit(:name, :address, :city_municipality_id, :organization_type_id)
    end

    def set_city_municipality
      city_municipality_id = params[:city_municipality_id]
    end
  end
end