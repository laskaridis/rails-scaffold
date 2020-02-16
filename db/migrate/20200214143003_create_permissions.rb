class CreatePermissions < ActiveRecord::Migration[5.2]
  def change
    create_table :permissions do |t|
      t.string :name,       null: false, limit: 255
      t.text   :description
      t.string :action,     null: false, limit: 255
      t.string :resource,   null: false, limit: 255

      t.timestamps
    end

    add_index :permissions, :name,                unique: true
    add_index :permissions, [:action, :resource], unique: true
  end
end
