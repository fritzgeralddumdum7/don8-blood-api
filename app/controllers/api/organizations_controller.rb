module Api
  class OrganizationsController < ApplicationController
    def index
      @organizations = Organization.joins(:organization_type, :city_municipality).select("organizations.id,
        organizations.name as organization_name,
        organization_types.name as organization_type_name,
        city_municipalities.name as city_municipality_name,
        city_municipalities.latitude,
        city_municipalities.longitude").uniq

      options={}
      options[:meta] = {total: Organization.count}
      render json:  OrganizationSerializer.new(@organizations, options)
    end
  
    def show
      @organization = Organization.find(params[:id])
      render json: @organization
    end
  
    def create
      @organization = Organization.new(organization_params)
      
      if @organization.save
        render json: @organization
      else
        render json: @organization.errors
      end
      
    end
  
    def update
      @organization = Organization.find(params[:id])

      if @organization.update(organization_params)
        render json: @organization
      else
        render json: @organization.errors
      end
    end
  
    def destroy
    end

    private

    def organization_params
        params.require(:organization).permit(:name, :address, :city_municipality_id, :organization_type_id)
    end
  end
end