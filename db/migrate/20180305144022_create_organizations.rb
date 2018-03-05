class CreateOrganizations < ActiveRecord::Migration[5.1]
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.references :address, foreign_key: true, null: false
      t.string :contact_first_name, null: false
      t.string :contact_last_name, null: false
      t.string :contact_email, null: false
      t.string :vat_number, null: false
      t.string :tax_office, null: false
      t.string :website

      t.timestamps
    end
  end
end
