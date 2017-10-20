module EventsHelper

	# Makes the user creating the event automatically an attendee.
	def attend_hosted_event(event)
		current_user.invites.create(event_id: event.id)
	end
end
