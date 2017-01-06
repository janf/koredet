class Admin::AccountsController < ApplicationController
	before_action :authenticate_user!
	
	def index 
		# puts "Admin::AccountsController#index"
		@accounts = Account.unscoped.all.order(account_name: :asc)
		@users = User.unscoped.all.order(email: :asc)
	  	@invitations = Invitation.unscoped.where(invitation_type: :new_account, status: :sent).order(to_email: :asc)
	end

	def show
		# puts "Account ID to show:" + params[:id].to_s
		@account = Account.unscoped.find(params[:id])
		@user_accounts = UserAccount.unscoped.where(account_id: params[:id])
		@invitations = Invitation.unscoped.where(account_id: params[:id])
		@num_items = Item.unscoped.where(account_id: params[:id]).count
		@num_locations = Location.unscoped.where(account_id: params[:id]).count
		@num_inventory = Inventory.unscoped.where(account_id: params[:id]).count
		@num_transactions = CartItem.unscoped.where(account_id: params[:id]).count
		@last_item = Item.unscoped.where(account_id: params[:id]).order(created_at: :desc).first
		@last_location = Location.unscoped.where(account_id: params[:id]).order(created_at: :desc).first
		UserAccount.unscoped do
			@last_user = User.joins( :user_accounts).where(user_accounts: {account_id: params[:id]}).order(last_sign_in_at: :desc).first
		end
	end

  	def invite_create_account
  		email = params[:email]
		# puts "Inviting: " + email
		# do something
		
		accinv = AccountInvitation.new(email, current_user.email)
				
		accinv.create_new_account_invitation
		accinv.send_invitation(new_user_registration_path)
		
  		flash[:notice] = "Invitation created"
  		redirect_back(fallback_location: root_url)
 	end

 	def cancel_invite_create_account
 		inv = Invitation.find(params[:invitation_id])
 		inv.status = :cancelled
 		inv.save!

 		flash[:notice] = "Invitation cancelled"
 		redirect_back(fallback_location: root_url)
 	end	
end
