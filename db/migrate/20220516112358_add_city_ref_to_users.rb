class AddCityRefToUsers < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :city_municipality, foreign_key: true
  end
end
