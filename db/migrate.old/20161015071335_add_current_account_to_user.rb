class AddCurrentAccountToUser < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :current_account, references: :accounts
   end
end
