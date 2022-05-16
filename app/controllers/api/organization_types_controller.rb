module Api
  class OrganizationTypesController < ApplicationController
    skip_before_action :authenticate_user!
    
    def index
      render json: OrganizationTypeSerializer.new(OrganizationType.all)
    end
  end
end
