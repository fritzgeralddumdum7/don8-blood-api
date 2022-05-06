class CreateBloodRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :blood_requests do |t|
      t.string :code
      t.timestamp :date_time
      t.references :user, null: false, foreign_key: true
      t.references :case, null: false, foreign_key: true
      t.references :organization, null: false, foreign_key: true
      t.references :request_type, null: false, foreign_key: true
      t.references :blood_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
