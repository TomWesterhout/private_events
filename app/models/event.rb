class Event < ApplicationRecord
	belongs_to :host, class_name: "User"
	has_many :invites, foreign_key: "event_id", dependent: :destroy
	has_many :attendees, through: :invites, source: "attendee", dependent: :destroy
end
