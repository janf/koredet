class SystemController < ApplicationController
	def show
		@accounts = Account.unscoped.all.order(account_name: :asc)
		@users = User.unscoped.all.order(email: :asc)
	  	@invitations = Invitation.unscoped.where(invitation_type: :new_account, status: :sent).order(to_email: :asc)
	end

  	def invite_create_account
  		email = params[:email]
		puts "Inviting: " + email
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
