class AddCountryToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :country, foreign_key: true
  end
end
