class AddLatLongToCityMunicipality < ActiveRecord::Migration[6.1]
  def change
    add_column :city_municipalities, :latitude, :float
    add_column :city_municipalities, :longitude, :float
  end
end