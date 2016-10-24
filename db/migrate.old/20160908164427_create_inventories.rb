class CreateInventories < ActiveRecord::Migration[5.0]
  def change
    create_table :inventories do |t|
      t.integer :qty
      t.references :location, foreign_key: true
      t.references :item, foreign_key: true

      t.timestamps
    end
  end
end
