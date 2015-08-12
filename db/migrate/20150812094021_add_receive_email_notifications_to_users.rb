class AddReceiveEmailNotificationsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :receive_email_notifications, :boolean, default: false
  end
end
