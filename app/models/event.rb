class Event < ApplicationRecord
	belongs_to :host, class_name: "User"
	has_many :invites, foreign_key: "event_id", dependent: :destroy
	has_many :attendees, through: :invites, source: "attendee", dependent: :destroy
	validates :name, presence: true, length: { maximum: 40 }
	validates :description, presence: true, length: { minimum: 10 }
	validates :location, presence: true
	validates :date, presence: true
	validates :time, presence: true
end
