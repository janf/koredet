class AccountsController < ApplicationController

	before_action :authenticate_user!
	before_action :set_account, only: [:show, :edit, :update, :invite_member]
	  
	def show
	end

	def edit
		authorize @account
	end

	def update
		authorize @account
	    respond_to do |format|
	      if @account.update(account_params)
	        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
	        format.json { render :show, status: :ok, account: @account }
	      else
	        format.html { render :edit }
	        format.json { render json: @account.errors, status: :unprocessable_entity }
	      end
	    end
	end

	def invite_member

		@email = params[:email]
		puts "Inviting: " + @email
		# do something
		
		msg = "Invitation sendt"

		accinv = Accountinvitation.new(@email, @account)
		
		if !(accinv.existing_member or accinv.existing_invitation)
			accinv.create_account_invitation(current_user.email)
			accinv.send_account_invitation(new_user_registration_path)
		else
			msg =  'User is already member or invited, inivtation not sent'
		end	


		redirect_to  @account,  notice: msg 

	end

	private

	    def set_account
	    	@account = Account.find(current_user.current_account_id)
	    	@user_accounts = UserAccount.all   
		end


		def account_params
      		params.require(:account).permit(:account_name)
    	end	
end
