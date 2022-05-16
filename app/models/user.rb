class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist
  belongs_to :blood_type, optional: true
  belongs_to :organization, optional: true
  validates :email, uniqueness: {
    message: "Email already exist"
  }
end
