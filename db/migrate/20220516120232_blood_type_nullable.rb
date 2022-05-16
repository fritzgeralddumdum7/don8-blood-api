class BloodTypeNullable < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :blood_type_id, :integer, null: true
  end
end
