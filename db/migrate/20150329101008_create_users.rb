class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :encrypted_password, limit: 128, null: false
      t.string :email_confirmation_token, limit: 128
      t.datetime :email_confirmation_requested_at
      t.datetime :email_confirmed_at
      t.string :password_change_token, limit: 128
      t.datetime :password_change_requested_at
      t.datetime :password_changed_at
      t.timestamps null: false
    end

    add_index :users, :email
  end
end
