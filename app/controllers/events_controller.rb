class EventsController < ApplicationController

	def index
		@events = Event.all
	end

	def show
		@event = Event.find(params[:id])
	end

	def new
		@event = Event.new
	end

	def create
		@event = current_user.events.build(event_params)
		if @event.save
			flash[:success] = "Event successfully created"
			redirect_to root_url
		else
			flash[:warning] = "Invalid submission"
			render 'new'
		end
	end

	private

		# Whitelists certain parameters to be used for mass assignment.
		def event_params
			params.require(:event).permit(:name, :description, :location, :date, :time)
		end
end
