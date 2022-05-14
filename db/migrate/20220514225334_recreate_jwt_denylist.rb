class RecreateJwtDenylist < ActiveRecord::Migration[6.1]
  def change
    drop_table :jwt_deny_lists
  end
end
