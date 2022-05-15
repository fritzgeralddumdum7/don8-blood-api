module Api
  class OrganizationTypesController < ApplicationController
    def index
      render json: OrganizationTypeSerializer.new(OrganizationType.all)
    end
  end
end
