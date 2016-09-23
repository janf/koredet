class CreateSearches < ActiveRecord::Migration[5.0]
  def change
    create_table :item_searches do |t|
      t.integer :item_type_id

      t.timestamps
    end
  end
end
