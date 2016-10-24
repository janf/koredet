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
		
		accinv = AccountInvitation.new(@email, current_user.email)

		account = @account
		
		if !(accinv.existing_member?(account.id) or accinv.existing_member_invitation?(account.id))
			accinv.create_member_invitation(@account)
			accinv.send_invitation(new_user_registration_path)
		else
			msg =  'User is already member or invited, inivtation not sent'
		end	

		redirect_to  @account,  notice: msg 
	end

	def admin_destroy
		# Should be moved to system_controller ? Is here to be restful
	    @account = Account.find(params[:id])
	    @account.destroy
		respond_to do |format|
	  		format.html { redirect_to :back, notice: 'Item was successfully destroyed.' }
	  		format.json { head :no_content }
      	end	
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
