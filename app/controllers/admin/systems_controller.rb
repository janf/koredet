class Admin::SystemsController < ApplicationController
	include StatisticsServices

	def show
        @user_activity = user_statistics_per_day
	end

end