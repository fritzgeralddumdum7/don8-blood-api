module Api
  class OrganizationsController < ApplicationController
    def index
        render json: Organization.all      
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