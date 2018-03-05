class CreateProductFamilies < ActiveRecord::Migration[5.1]
  def change
    create_table :product_families do |t|
      t.string :name
      t.references :product_category, foreign_key: true

      t.timestamps
    end
  end
end
