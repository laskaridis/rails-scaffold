class AddCurrencyToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :currency, foreign_key: true
  end
end
