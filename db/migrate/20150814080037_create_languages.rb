class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.string :code, limit: 2, null: false
      t.timestamps
    end

    add_index :languages, :code, unique: true
  end
end
