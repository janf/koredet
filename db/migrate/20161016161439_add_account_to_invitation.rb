class AddAccountToInvitation < ActiveRecord::Migration[5.0]
  def change
    add_reference :invitations, :accounts, foreign_key: true
  end
end
