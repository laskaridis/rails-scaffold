class CreateOrganizations < ActiveRecord::Migration[5.1]
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.references :user, foreign_key: true
      t.references :address, foreign_key: true
      t.references :contact, foreign_key: true
      t.string :vat_number, null: false
      t.string :tax_office, null: false
      t.string :website

      t.timestamps
    end
  end
end
