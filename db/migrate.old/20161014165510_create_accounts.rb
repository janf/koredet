class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.string :account_name
      t.boolean :account_active

      t.timestamps
    end
  end
end
