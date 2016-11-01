class AccountSetupValues
  include ActiveModel::Model

  attr_accessor :account_name, :invite_emails

  #validates :email, presence: true, length: {in:2..255}

  def save
  	#do nothing
  end	

end