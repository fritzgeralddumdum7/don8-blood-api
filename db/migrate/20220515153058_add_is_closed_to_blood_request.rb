class AddIsClosedToBloodRequest < ActiveRecord::Migration[6.1]
  def change
    add_column :blood_requests, :is_closed, :boolean, :default => false
  end
end
