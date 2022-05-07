class CreateAppointments < ActiveRecord::Migration[6.1]
  def change
    create_table :appointments do |t|
      t.timestamp :date_time
      t.references :user, null: false, foreign_key: true
      t.references :blood_request, null: false, foreign_key: true
      t.boolean :is_completed
      t.integer :status

      t.timestamps
    end
  end
end
