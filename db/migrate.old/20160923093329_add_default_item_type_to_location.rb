class AddDefaultItemTypeToLocation < ActiveRecord::Migration[5.0]

  def change
  	 add_column :locations, :default_item_type_id, :integer
  end
  
end
