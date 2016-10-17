class ApplicationController < ActionController::Base
	
	include Pundit

	protect_from_forgery with: :exception

	set_current_tenant_through_filter

	before_action :set_tenant

	def set_tenant
		if user_signed_in?
			set_current_tenant(current_user.current_account)
			puts "User: " + current_user.email 
			if current_user.current_account_id.nil?
				puts " Account:  is nil"
			else
				puts " Account:  " + current_user.current_account_id.to_s
				puts " From ActsAsTenanat: " + ActsAsTenant.current_tenant.id.to_s
			end	
		end

	end

end
