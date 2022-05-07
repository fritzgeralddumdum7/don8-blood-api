class CreateDonations < ActiveRecord::Migration[6.1]
  def change
    create_table :donations do |t|
      t.timestamp :harvest_date
      t.references :appointment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
