class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :street, null: false
      t.string :city, null: false
      t.string :region, null: false
      t.string :postal_code, null: false
      t.references :country, foreign_key: true

      t.timestamps
    end
  end
end
