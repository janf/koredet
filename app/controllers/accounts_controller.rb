class AccountsController < ApplicationController

	before_action :set_account, only: [:show, :edit]
	  
	def show
	end

	def edit
	end

	private

	    def set_account
	    	@account = Account.find(current_user.current_account_id)
	    	puts "loading user_account"
	    	@user_accounts = UserAccount.all

	    	puts "First user at account: " + @user_accounts.first.user.email
		end
end
