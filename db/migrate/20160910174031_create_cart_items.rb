class CreateCartItems < ActiveRecord::Migration[5.0]
  def change
    create_table :cart_items do |t|
      t.references :items, foreign_key: true
      t.integer :qty
      t.timestamps
    end
  end
end
