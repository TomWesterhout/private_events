class UsersController < ApplicationController
	before_action :correct_user, only: [:edit, :update]

	def show
		@user = User.find(params[:id])
		@events = []
		if request.fullpath.include?('host_upcoming=true')
			@events = @user.hosted_events.upcoming
		elsif request.fullpath.include?('host_past=true')
			@events = @user.hosted_events.past
		elsif request.fullpath.include?('attend_upcoming=true')
			@events = @user.attended_events.upcoming
		elsif request.fullpath.include?('attend_past=true')
			@events = @user.attended_events.past
		end
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			log_in @user
			flash[:success] = "Registered successfully."
			redirect_to root_url
		else
			flash.now[:warning] = "Invalid information"
			render 'new'
		end
	end

	def edit
	end

	def update
		if @user.update_attributes(user_params)
			flash[:success] = "Profile updated."
			redirect_to @user
		else
			flash.now[:warning] = "Invalid information"
			render 'edit'
		end
	end

	private

		# Whitelists certain parameters to be used for mass assignment.
		def user_params
			params.require(:user).permit(:name, :password, :password_confirmation)
		end

		# Checks whether the logged in user is the same as the user page requested.
		def correct_user
			@user = User.find(params[:id])
			redirect_to root_url unless @user == current_user
		end
end
