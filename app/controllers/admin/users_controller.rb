class Admin::UsersController < ApplicationController
	
	before_action :authenticate_user!

	def show
        @user = User.find(params[:id])
    end

	def index
        @users = User.all.order(email: :asc)
    end



end