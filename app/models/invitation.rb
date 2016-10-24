class Invitation < ApplicationRecord

	belongs_to :account, foreign_key: "accounts_id"
	
	enum status: [ :created, :sent, :accepted, :rejected, :cancelled, :expired ]
	enum invitation_type: [ :member, :new_account ]

	validates_format_of :to_email,:with => Devise::email_regexp


	def open_invitation
		[:created.to_s, :sent.to_s].include? self.status  
	end

	def set_expiry_date
		self.expiry_date = Date.today + 30
	end


	def generate_token
  		self.token = Digest::SHA2.hexdigest([Time.now, rand].join)
	end

	def invitation_valid?
		invitation_type.status == :sent and Date.today <= self.expiry_date
	end	

end
