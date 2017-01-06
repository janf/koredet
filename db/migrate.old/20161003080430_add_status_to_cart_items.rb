class AddStatusToCartItems < ActiveRecord::Migration[5.0]
  def up
    add_column :cart_items, :status_code, :string, default: "O"
    add_column :cart_items, :status_text, :string
    CartItem.update_all(status_code: "O")
  end

  def down
  	remove_column :cart_items, :status_code
  	remove_column :cart_items, :status_txt
  end
end
