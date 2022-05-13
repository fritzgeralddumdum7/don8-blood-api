module Api
	class CasesController < ApplicationController
		def index
      		render json: CaseSerializer.new(Case.all)
		end
  end	
end