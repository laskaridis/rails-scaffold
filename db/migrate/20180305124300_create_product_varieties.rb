class CreateProductVarieties < ActiveRecord::Migration[5.1]
  def change
    create_table :product_varieties do |t|
      t.string :name, :unique
      t.references :product_family, foreign_key: true

      t.timestamps
    end
  end
end
