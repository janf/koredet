class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.references :from_locations, references: :locations	
      t.references :to_locations, references: :locations
      t.references :items	
      t.integer :qty
      t.timestamps
    end
  end
end
