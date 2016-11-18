class ChangeColunNameInvitation < ActiveRecord::Migration[5.0]
  def change
  	rename_column :invitations, :accounts_id, :account_id
  end
end
