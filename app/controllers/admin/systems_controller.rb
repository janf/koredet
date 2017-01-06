class Admin::SystemsController < ApplicationController
	include StatisticsServices

	before_action :authenticate_user!
		
	def show
        @user_activity = user_statistics_per_day
	end

end