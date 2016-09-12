class AddProcessStatusToCart < ActiveRecord::Migration[5.0]
  def change
    add_column :carts, :process_status, :string
  end
end
