class ChangeDefaultvalueForStatusInAppointment < ActiveRecord::Migration[6.1]
  def change
    change_column_default :appointments, :status, 1 
  end
end
