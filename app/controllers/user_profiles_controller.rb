class UserProfilesController < ApplicationController
  before_action :authenticate_user!

  @readonly = true

  def show
  	@user = current_user
  	@user_accounts = UserAccount.unscoped.where(user_id: @user.id)
  	@invitations = Invitation.unscoped.where(to_email: @user.email, invitation_type: :member, status: :sent)
    @readonly = false
  end

  def edit
    @user = current_user
    @user_accounts = UserAccount.unscoped.where(user_id: @user.id)
    @invitations = Invitation.unscoped.where(to_email: @user.email, invitation_type: :member, status: :sent)
    @readonly = false
    render :show
  end

  def update
    puts "Readonly: " + @readonly.to_s
    if @readonly == true then
      @readonly = false
    else  
      puts "updating user 2"
      @user = current_user
      puts params[:user].to_s
      puts user_params.to_yaml
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to action: "show", notice: 'User info was successfully updated.' }
          format.json { render :show, status: :ok, location: @location }
        else
          format.html { render :edit }
          format.json { render json: @location.errors, status: :unprocessable_entity }
        end
      end
      @readonly = true  
     end 
  end


  def accept_invitation

  	token = params[:token]
  	invitation = Invitation.find_by(token: token)

  	if invitation.present?
  		user_account = UserAccount.new
  		user_account.account_id = invitation.accounts_id
  		user_account.user_id = current_user.id
  		user_account.account_admin = false
  		
  		if user_account.save!
  		  	if current_user.user_accounts.count == 1
  		  		current_user.current_account = user_account.account
  		  		current_user.save!
  		  		set_current_tenant(current_user.current_account)
  		  		invitation.status = :accepted
  		  		invitation.save!
  		  		#redirect_back fallback_location: root_url, notice: 'Invition was successfully updated.'
  		  	end	
  		else
  			#redirect_to action: "show",	notice: 'Unable to process invitation now, try again later'
  		end
  	end

  	redirect_to action: "show"
  end 


  private
    # Use callbacks to share common setup or constraints between actions.
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:firstname, :lastname, :address, :postcode, :postname, :country)
    end
end
