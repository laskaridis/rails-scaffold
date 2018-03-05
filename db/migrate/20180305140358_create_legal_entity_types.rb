class CreateLegalEntityTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :legal_entity_types do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
