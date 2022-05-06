class OrganizationType < ApplicationRecord
    belongs_to :organization_type
    has_many :organizations
    validates :name, presence: true, uniqueness: true    
end
