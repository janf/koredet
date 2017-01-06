class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :accounts,  :through => :user_accounts
  has_many :user_accounts
  belongs_to :current_account, class_name: "Account"



  def current_account_admin?
  	ua = UserAccount.where(account_id: current_account.id, user_id: self.id).first
  	if ua.present?
  		return ua.account_admin
  	else
  	 	return false	
  	end 
  end

end
