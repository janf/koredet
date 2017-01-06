class Admin::StatisticsController < ApplicationController
	include StatisticsServices

	before_action :authenticate_user!

	def show
      
	end

end