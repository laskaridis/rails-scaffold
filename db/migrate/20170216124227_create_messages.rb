class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :sender_id, null: false
      t.integer :recipient_id, null: false
      t.string :subject, null: false
      t.string :message, null: false
      t.boolean :read, null: false, default: false
      t.timestamps null: false
    end

    add_foreign_key :messages, :users, column: :sender_id
    add_foreign_key :messages, :users, column: :recipient_id
  end
end
