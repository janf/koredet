class AddAccountIdToTables < ActiveRecord::Migration[5.0]
  def change
  	 tables = [:item_types, :items, :item_fields, :locations, :inventories, :transaction_types, :transactions, :carts, :cart_items ]

	tables.each do |table_name|
	    add_reference table_name, :account,  index: true
	    add_foreign_key table_name, :accounts
	end
  end
end
