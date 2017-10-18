class EventsController < ApplicationController

	def index
		if request.fullpath.include?('upcoming=true')
			@events = Event.upcoming
		elsif request.fullpath.include?('past=true')
			@events = Event.past
		else
			@events = Event.all
		end
	end

	def show
		@event = Event.find(params[:id])
		@attendees = @event.attendees
	end

	def new
		if current_user.nil?
			flash[:warning] = "Please log in to create an event"
			redirect_to login_path
		else
			@event = Event.new
		end
	end

	def create
		@event = current_user.hosted_events.build(event_params)
		if @event.save
			flash[:success] = "Event successfully created"
			redirect_to @event
		else
			flash.now[:warning] = "Invalid submission"
			render 'new'
		end
	end

	private

		# Whitelists certain parameters to be used for mass assignment.
		def event_params
			params.require(:event).permit(:name, :description, :location, :date, :time)
		end
end
