class AddSizeToOrganizations < ActiveRecord::Migration[5.1]
  def change
    add_column :organizations, :size, :string
  end
end
