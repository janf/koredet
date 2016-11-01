class AddAccountToNameIndex < ActiveRecord::Migration[5.0]
  def change
  	remove_index :items, :name
  	add_index :items, [:account_id, :name], unique: true
  end
end
