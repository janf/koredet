class AccountInvitation

	def initialize(v_to_email, v_from_email)
		@to_email   = v_to_email
		@from_email = v_from_email
	end	


	def existing_member?(account_id)
		@user = User.find_by(email: @to_email)
		if @user.present? then
			useraccount = UserAccount.exists?(user_id: @user.id, account_id: account_id)
		else
			false
		end		
	end

	def existing_member_invitation?(account_id)
		Invitation.exists?(to_email: @to_email, account_id: account_id, status: :sent, invitation_type: :member)
	end	


	def create_member_invitation(account)
		inv = Invitation.new
		inv.account_id = account.id
		inv.to_email = @to_email
		inv.from_email = @from_email
		inv.invitation_type = :member
    	inv.status = :created
    	inv.set_expiry_date
    	inv.generate_token
    	inv.save
    	@inv = inv
	end

	def create_new_account_invitation
		inv = Invitation.new
		inv.to_email = @to_email
		inv.from_email = @from_email
		inv.invitation_type = :new_account
    	inv.status = :created
    	inv.set_expiry_date
    	inv.generate_token
    	inv.save
    	# puts inv.to_yaml
    	@inv = inv
	end


	def send_invitation( signup_path )
		if !@inv.present? 
			return false
		end
		
		@sup = signup_path

		# puts "Signup path: " +  @sup
		if @inv.invitation_type == :member
			AccountMailer.meber_invite_mail(@inv, @sup ).deliver_later
		else
			AccountMailer.new_account_invite_mail(@inv, @sup ).deliver_later
		end
		@inv.status = :sent
		@inv.save
		true
	end


end