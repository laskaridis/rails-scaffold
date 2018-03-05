class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :encrypted_password, limit: 128, null: false
      t.string :full_name, null: false
      t.string :email_confirmation_token, limit: 128
      t.datetime :email_confirmation_requested_at
      t.datetime :email_confirmed_at
      t.string :password_change_token, limit: 128
      t.datetime :password_change_requested_at
      t.datetime :password_changed_at
      t.string :gender
      t.datetime :birth_date
      t.string :time_zone, null: false, default: "UTC"
      t.boolean :receive_email_notifications, default: false
      t.timestamps null: false
    end

    add_index :users, :email
  end
end
