class ChangeDefaultvalueForIsCompleted < ActiveRecord::Migration[6.1]
  def change
    change_column_default :appointments, :is_completed, false 
  end
end
