class AddTypeToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :item_type_id, :integer
    add_column :items, :properties, :text
  end
end
