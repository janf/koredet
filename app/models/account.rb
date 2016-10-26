class Account < ApplicationRecord
	has_many :user_accounts, :dependent => :destroy
	has_many :users, :through => :user_accounts
	has_many :invitations, :foreign_key => :accounts_id, :dependent => :destroy


	def account_admins
		admins = UserAccount.unscoped.where(account_id: self.id, account_admin: true)
	end	
end
