class AccountPolicy < ApplicationPolicy

 	def edit?
 		is_account_admin?
 	end	


 	def update?
 		
 	end	

 	def admin_destroy?
 		is_account_admin?
 	end

 	private

 	def is_account_admin??
 		user_account = UserAccount.where(user_id: current_user.id).first
 		user_account.account_admin
 	end

end

