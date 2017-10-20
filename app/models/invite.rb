class Invite < ApplicationRecord
	belongs_to :attendee, class_name: "User"
	belongs_to :event, class_name: "Event"
	validates :event_id, presence: true
	validates :attendee_id, presence: true
end
