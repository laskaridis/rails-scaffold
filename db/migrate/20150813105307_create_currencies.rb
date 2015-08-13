class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.string :code, limit: 3, null: false
      t.string :symbol, limit: 3, null: false
      t.timestamps
    end

    add_index :currencies, :code, unique: true
  end
end
