class AddColumnsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :address, :string
    add_column :users, :postcode, :string
    add_column :users, :postname, :string
    add_column :users, :country, :string
    add_column :users, :global_admin, :boolean, default: false
  end
end
