module Api
	class DonationsController < ApplicationController
		def index
			all_donations = Donation.joins(:appointment => :blood_request).uniq

			options={}
      options[:meta] = {total: all_donations.count}
			render json: DonationSerializer.new(all_donations, options)
		end
		
		def show
			render json: serialize_donation(params[:id])
		end

		def create
			donation = Donation.new(donation_params)

			if donation.save
				render json: serialize_donation(donation.id)
			else
				render json: {errors: donation.errors}
			end
		end

		private

		def donation_params
			params.require(:donation).permit(:harvest_date, :appointment_id)
		end

		def get_appointment_id
			params[:appointment_id].to_i
		end

		def serialize_donation(id)
			donation = Donation.joins(:appointment => :blood_request).where(:id => id)

			DonationSerializer.new(donation)
		end
		
	end
end