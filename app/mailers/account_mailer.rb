class AccountMailer < ApplicationMailer
	#default :from = "donotreply@havie.net"

	def member_invite_mail(invitation, signup_path)
		inv = invitation
		
		#puts "Start sending mail..."
		@signup_url = root_url + signup_path + "?token=" + inv.token
		
		#puts "Sending mail to " + inv.to_email + "with URL: " + signup_url
		mail(:to => inv.to_email, :subject => "You have been invited to join")
		puts "Sent mail to " + inv.to_email
	end


	def new_account_invite_mail(invitation, signup_path)
		inv = invitation
		
		#puts "Start sending mail..."
		@signup_url = root_url + signup_path + "?token=" + inv.token
		
		#puts "Sending mail to " + inv.to_email + "with URL: " + signup_url
		mail(:to => inv.to_email, :subject => "You have been invited to create an account with Koredet")
		# puts "Sent mail to " + inv.to_email
	end


end
