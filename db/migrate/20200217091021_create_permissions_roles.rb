class CreatePermissionsRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :permissions_roles do |t|
      t.integer :role_id, null: false
      t.integer :permission_id, null: false
    end
    add_index :permissions_roles, [:role_id, :permission_id], unique: true
  end
end
