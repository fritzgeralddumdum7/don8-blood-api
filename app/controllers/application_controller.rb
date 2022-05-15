class ApplicationController < ActionController::API
    before_action :authenticate_user!
    before_action :configure_permitted_parameters, if: :devise_controller?

    def render_json_api_response resource
        if resource.errors.empty?
            render json: resource
        else
            render json: resource.errors, status: 400
        end
    end

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [
                :blood_type_id,
                :email,
                :password,
                :firstname,
                :lastname,
                :birthday,
                :city,
                :middlename,
                :address
            ]
        )
    end
end
