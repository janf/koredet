class AccountPolicy < ApplicationPolicy

 	def edit?
 		user_account = UserAccount.where(user_id: user.id).first
 		user_account.account_admin
 	end	


 	def update?
 		user_account = UserAccount.where(user_id: user.id).first
 		user_account.account_admin
 	end	

end