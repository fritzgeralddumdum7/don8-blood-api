class CreateCityMunicipalities < ActiveRecord::Migration[6.1]
  def change
    create_table :city_municipalities do |t|
      t.string :name
      t.references :province, null: false, foreign_key: true

      t.timestamps
    end
  end
end
