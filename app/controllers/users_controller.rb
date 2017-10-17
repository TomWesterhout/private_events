class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
		@upcoming_events = @user.upcoming_events
		@previous_events = @user.previous_events
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			flash[:success] = "Registered successfully."
			redirect_to root_url
		else
			render 'new'
		end
	end

	def edit
		@user = User.find(params[:id])
		redirect_to root_url if @user != current_user
	end

	def update
	end

	private

		def user_params
			params.require(:user).permit(:name, :password, :password_confirmation)
		end
end
