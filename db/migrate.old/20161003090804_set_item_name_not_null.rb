class SetItemNameNotNull < ActiveRecord::Migration[5.0]
  def change
  	change_column_null :items, :name, false
  	add_index :items, :name, :unique => true
  end
end
