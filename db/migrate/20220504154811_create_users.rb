class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :firstname
      t.string :middlename
      t.string :lastname
      t.date :birthday
      t.text :address
      t.integer :availability_status
      t.string :mobile_no
      t.references :blood_type, null: false, foreign_key: true
      t.float :longitude
      t.float :latitude

      t.timestamps
    end
  end
end
