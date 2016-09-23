class AddDateToCartItems < ActiveRecord::Migration[5.0]
  def change
    add_column :cart_items, :arrival_date, :date
  end
end
