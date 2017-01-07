class AccountSetupController < ApplicationController
	include Wicked::Wizard

	before_action :authenticate_user!
	before_action :set_account_setup_values

	steps :overview, :set_name, :invite_members, :setup_item_types, :setup_locations, :setup_transactions, :show_summary





	def show
	  	render_wizard
  	end

	def edit
	  	render_wizard
  	end


  	def update
  		case step
	    when :set_name
	    	@account.update!(account_params)
	    	jump_to( next_step )
	    when :invite_members	
	    	accinv = AccountInvitation.new(params[:email], current_user.email)
			account = current_user.current_account
			accinv.create_member_invitation(account)
			accinv.send_invitation(new_user_registration_path)
			flash[:notice] =s 'New member invited.'
		when :setup_item_types
			asit = AccountSetupItemTypes.new()
			asit.add_item_types(current_user.current_account)
			flash[:notice] ='Standard item types successfully updated.'
		when :setup_locations
	    	asil = AccountSetupLocations.new()
			asil.add_locations(current_user.current_account)
			flash[:notice] ='Standard locations successfully updated.'
  		when :setup_transactions
  			asit = AccountSetupTransactionTypes.new()
  			asit.add_transaction_types(current_user.current_account)
  			flash[:notice] ='Standard transactions successfully updated.'
  		end

  		render_wizard 
   	end	

  	
   	private 

  	def set_account_setup_values
  		case step
	    when :set_name
	    	@account = current_user.current_account
	    when :invite_members
	    	@invitations = Invitation.where(account_id: current_user.current_account.id) # Is not scoped
	    when :setup_item_types
	    	@item_types = ItemType.all	
	    	@items = Item.all
		when :setup_locations
		   	@locations = Location.all	
		when :setup_transactions
			@transaction_types = TransactionType.all
		when :show_summary
			@account = current_user.current_account
			@item_types = ItemType.all	
			@locations = Location.all	
			@transaction_types = TransactionType.all
	    end
    end

    def account_params
      params.require(:account).permit(:account_name)
    end

end
