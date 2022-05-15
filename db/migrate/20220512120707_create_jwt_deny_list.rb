class CreateJwtDenyList < ActiveRecord::Migration[6.1]
  def change
    create_table :jwt_deny_lists do |t|

      t.timestamps
    end
  end
end
