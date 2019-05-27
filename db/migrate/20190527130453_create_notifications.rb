class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.string     :subject, null: false, length: 100
      t.string     :type,    null: false, length: 50
      t.text       :body,    null: false
      t.boolean    :read
      t.references :user, foreign_key: true
      t.timestamps null: false
    end
  end
end
