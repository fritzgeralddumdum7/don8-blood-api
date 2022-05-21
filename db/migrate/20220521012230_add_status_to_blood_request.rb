class AddStatusToBloodRequest < ActiveRecord::Migration[6.1]
  def change
    add_column :blood_requests, :status, :integer, null: false, :default => 1
  end
end
