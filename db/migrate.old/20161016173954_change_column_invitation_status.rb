class ChangeColumnInvitationStatus < ActiveRecord::Migration[5.0]
  
  def self.up
  	change_column :invitations, :status,   'integer USING CAST(status AS integer)'
  	change_column :invitations, :invitation_type,   'integer USING CAST(invitation_type AS integer)'
  end

  def self.down
	change_column :invitations, :status,  'text USING CAST(status AS text)'
	change_column :invitations, :invitation_type,   'text USING CAST(invitation_type AS text)'
  end	
end
