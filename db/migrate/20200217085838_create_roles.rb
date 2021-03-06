class CreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :roles do |t|
      t.string :name, null: false, limit: 255
      t.text   :description

      t.timestamps
    end
    add_index :roles, :name, unique: true
  end
end
