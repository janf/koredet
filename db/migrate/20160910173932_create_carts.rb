class CreateCarts < ActiveRecord::Migration[5.0]
  def change
    create_table :carts do |t|
      t.references :from_locations, references: :locations	
      t.references :to_locations, references: :locations
      t.timestamps
    end
  end
end
