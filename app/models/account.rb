class Account < ApplicationRecord
	has_many :user_accounts
	has_many :users, :through => :user_accounts
	has_many :invitations, :foreign_key => :accounts_id


	def account_admins
		admins = UserAccount.where(account_id: self.id, account_admin: true)
	end	
end
