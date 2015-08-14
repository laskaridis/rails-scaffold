class AddLanguageToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :language, foreign_key: true
  end
end
