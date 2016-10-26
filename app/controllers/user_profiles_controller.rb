class UserProfilesController < ApplicationController
  before_action :authenticate_user!

  @readonly = true

  def show
  	@user = current_user
  	@user_accounts = UserAccount.unscoped.where(user_id: @user.id).order(:id)
  	@member_invitations = Invitation.unscoped.where(to_email: @user.email, invitation_type: :member, status: :sent)
    @new_account_invitations = Invitation.unscoped.where(to_email: @user.email, invitation_type: :new_account, status: :sent)
    @readonly = false
  end

  #def edit
  #  @user = current_user
  #  @user_accounts = UserAccount.unscoped.where(user_id: @user.id)
  #  @invitations = Invitation.unscoped.where(to_email: @user.email, invitation_type: :member, status: :sent)
  #  @readonly = false
  #  render :show
  #end

  def update
    if @readonly == true then
      @readonly = false
    else  
      @user = current_user
      respond_to do |format|
        if @user.update(user_params)
          format.html { flash[:notice] = 'User info was successfully updated.' 
                        redirect_to action: "show"  
                      }
          format.json { render :show, status: :ok, location: @location }
        else
          format.html { render :edit }
          format.json { render json: @location.errors, status: :unprocessable_entity }
        end
      end
      @readonly = true  
     end 
  end

  def change_current_account
    #puts params.to_yaml
    
    current_user.current_account = Account.find(params[:account_id])
    current_user.save!
    set_current_tenant(current_user.current_account)
    redirect_to action: "show"
  end


  def member_invitation

  	token = params[:token]
  	invitation = Invitation.find_by(token: token)

  	if invitation.present?
  		
  		if create_user_account(invitation.accounts_id, false)
		  	if current_user.user_accounts.count == 1
		  		current_user.current_account = Account.find(invitation.accounts_id)
		  		current_user.save!
		  		set_current_tenant(current_user.current_account)
        end  
		  	invitation.status = :accepted
		  	invitation.save!
  		else
  			#redirect_to action: "show",	notice: 'Unable to process invitation now, try again later'
  		end
  	end

  	redirect_to action: "show"
  end 

  def new_account_invitation
    token = params[:token]
    invitation = Invitation.find_by(token: token)
    if invitation.present?
      account = Account.new
      account.account_name = invitation.to_email + "-" + invitation.id.to_s
      account.account_active = true
      account.save
      puts "Created new account. ID: " + account.id.to_s
      if account.save!
        create_user_account(account.id, true)        
        current_user.current_account = account
        current_user.save!
        invitation.status = :accepted
        invitation.save!
      end
    end
    @account = account
    redirect_to @account
  end


  private
    # Use callbacks to share common setup or constraints between actions.

    def create_user_account(account_id, is_admin)
      #See if relation already exists
      puts "User.id: " + current_user.id.to_s + " , Account ID: " + account_id.to_s
      exist_user_account = UserAccount.unscoped.where(user_id: current_user.id, account_id: account_id)
      if exist_user_account.length > 0 
         return false
      end

      # Do the insert directly by SQL to circumvent default scope set by Acts_as_tenant
      sql = "INSERT INTO  user_accounts(account_id, user_id, account_admin, created_at, updated_at) VALUES(" 
      sql = sql + account_id.to_s  
      sql = sql + ", " + current_user.id.to_s
      sql = sql + ", " + is_admin.to_s
      sql = sql + ", localtimestamp, localtimestamp)"
      ActiveRecord::Base.connection.execute(sql)   
      return true
    end  
      
  
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:firstname, :lastname, :address, :postcode, :postname, :country)
    end
end
