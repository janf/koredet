class CreateTransactionTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :transaction_types do |t|
      t.string :description
      t.references :from_location, references: :location
      t.references :to_location, references: :location
      t.timestamps 
    end
  end
end
