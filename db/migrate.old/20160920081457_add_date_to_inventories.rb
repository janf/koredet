class AddDateToInventories < ActiveRecord::Migration[5.0]
  def change
    add_column :inventories, :arrival_date, :date
  end
end
