module SessionsHelper

	# Sets a session cookie for the user that logs in.
	def log_in(user)
		session[:user_id] = user.id
	end

	# Adds a remember token in digest form to the database and creates two cookies for the user that logs in.
	def remember(user)
		user.remember
		cookies.permanent.signed[:user_id] = user.id
		cookies.permanent[:remember_token] = user.remember_token
	end

	# Returns the current logged in user.
	def current_user
		if (user_id = session[:user_id])
			@current_user ||= User.find_by(id: user_id)
		elsif (user_id = cookies.signed[:user_id])
			user = User.find_by(id: user_id)
			if user && user.authenticated(cookies[:remember_token])
				log_in user
				@current_user = user
			end
		end
	end

	# Calls the current_user method above to check for a logged in user.
	def logged_in?
		!current_user.nil?
	end

	# Deletes the rember token digest from the database and both cookies.
	def forget(user)
		user.forget
		cookies.delete(:user_id)
		cookies.delete(:remember_token)
	end

	# Calls the forget method above, deletes the session cookie and sets the current user instance variable to nil.
	def log_out
		forget(current_user)
		session.delete(:user_id)
		@current_user = nil
	end
end
