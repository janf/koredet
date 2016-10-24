class FixColumnnames < ActiveRecord::Migration[5.0]
  def change
  	  rename_column :transactions, :from_locations_id, :from_location_id
  	  rename_column :transactions, :to_locations_id, :to_location_id
  	  rename_column :carts, :from_locations_id, :from_location_id
  	  rename_column :carts, :to_locations_id, :to_location_id
  	  rename_column :cart_items, :items_id, :item_id
  	   
  end
end
