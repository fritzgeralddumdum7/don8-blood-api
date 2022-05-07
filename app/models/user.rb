class User < ApplicationRecord
  belongs_to :blood_type
  has_many :notifications, as: :recipient
end
