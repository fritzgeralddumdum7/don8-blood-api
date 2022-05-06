class CreateRequestTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :request_types do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
