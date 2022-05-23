module Api
	class CasesController < ApplicationController
		def index
      render json: CaseSerializer.new(Case.all)
		end

		def show 
			render json: serialize_case(params[:id])
		end

		def create
			newcase = Case.new(case_params)

			if newcase.save
				render json: serialize_case(newcase.id)
			else
				render json: {errors: newcase.errors}
			end
		end

		def update
			selectedcase = Case.find(params[:id])
			
			if selectedcase.update(case_params)
        render json: serialize_case(selectedcase.id)
      else
        render json: {errors: selectedcase.errors}
      end

		end

		private

		def case_params
			params.require(:case).permit(:name, :description)
		end

		def serialize_case(id)
			selectedCase = Case.find(id)

			CaseSerializer.new(selectedCase)
		end

  end	
end