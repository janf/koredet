class AddNameToTransactionType < ActiveRecord::Migration[5.0]
  def change
    add_column :transaction_types, :name, :string
  end
end
