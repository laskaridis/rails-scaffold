class CreateCountries < ActiveRecord::Migration[5.1]
  def change
    create_table :countries do |t|
      t.string :code, limit: 2, null: false
      t.timestamps
    end

    add_index :countries, :code, unique: true
  end
end
