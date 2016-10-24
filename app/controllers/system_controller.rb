class SystemController < ApplicationController
	def show
		@users = User.unscoped.all.order(created_at: :desc)
	  	@accounts = Account.unscoped.all.order(created_at: :desc)
	end

  	def invite_create_member
  		email = params[:email]
		puts "Inviting: " + email
		# do something
		
		accinv = AccountInvitation.new(email, current_user.email)
				
		accinv.create_new_account_invitation
		accinv.send_invitation(new_user_registration_path)
		
  		flash[:notice] = "Invitation created"
  		redirect_back(fallback_location: root_url)
 	end
end
