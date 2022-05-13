module Api
  class RequestTypesController < ApplicationController
    def index
      render json: RequestTypeSerializer.new(RequestType.all)
    end
  end
end