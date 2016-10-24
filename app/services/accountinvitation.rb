class AccountInvitation

	def initialize(to_email, account)
		@to_email = to_email
		@account = account
		@user = nil
		@inv = nil
	end

	#def existing_user
	#	User.exists?(email: @to_email)
	#end

	def existing_member
		@user = User.find_by(email: @to_email)
		if @user.present? then
			useraccount = UserAccount.exists?(user_id: @user.id, account_id: @account.id)
		else
			false
		end		
	end

	def existing_invitation
		Invitation.exists?(to_email: @to_email, accounts_id: @account.id, status: :sent)
	end	

	def create_account_invitation(from_email = nil)
		inv = Invitation.new
		inv.accounts_id = @account.id
		inv.to_email = @to_email
		inv.from_email = from_email
		inv.invitation_type = :member
    	inv.status = :created
    	inv.set_expiry_date
    	inv.generate_token
    	inv.save

    	@inv = inv
	end

	def send_account_invitation( signup_path )
		if !@inv.present? 
			return false
		end
		
		@sup = signup_path

		puts "Signup path: " +  @sup

		AccountMailer.member_invite_mail(@inv, @sup ).deliver_later
		@inv.status = :sent
		@inv.save
		true
	end


end