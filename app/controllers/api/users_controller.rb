module Api
    require 'bcrypt'
    
    class UsersController < ApplicationController
        def index
            all_users = User.select("users.id,
              CONCAT(users.firstname,' ', users.lastname) as name,
              role").where(role: get_role)
      
            # options={}
            # options[:meta] = {total: all_users.count}
            render json: UserSerializer.new(all_users)
        end
          
        def profile
            render json: { data: current_user, city_municipality: current_user.city_municipality }
        end

        def validate_password
            is_matched = BCrypt::Password.new(current_user.encrypted_password) == params[:password]
            error = 'Password entered is incorrect' if !is_matched
            render json: { error: error }
        end

        def update_password
            user = User.find(current_user.id)
            user.encrypted_password = BCrypt::Password.create(user_params[:new_password])
            user.save!
            render json: { message: 'Password updated successfully' }
        end

        private

        def get_role
            params[:role].to_i
        end

        def user_params
            params.require(:user).permit(
                :new_password,
                :password
            )
        end
    end
end
