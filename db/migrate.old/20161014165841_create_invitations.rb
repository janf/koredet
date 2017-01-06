class CreateInvitations < ActiveRecord::Migration[5.0]
  def change
    create_table :invitations do |t|
      t.string :to_email
      t.string :from_email
      t.string :token
      t.string :invitation_type
      t.string :status
      t.date   :expiry_date

      t.timestamps
    end
  end
end
