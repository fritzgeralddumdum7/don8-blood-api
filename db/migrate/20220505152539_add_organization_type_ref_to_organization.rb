class AddOrganizationTypeRefToOrganization < ActiveRecord::Migration[6.1]
  def change
    add_reference :organizations, :organization_type, null: false, foreign_key: true
  end
end
