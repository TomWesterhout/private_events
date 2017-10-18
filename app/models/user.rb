class User < ApplicationRecord
	attr_accessor :remember_token
	has_many :hosted_events, foreign_key: "host_id", class_name: "Event", dependent: :destroy
	has_many :invites, foreign_key: "attendee_id", dependent: :destroy
	has_many :attended_events, through: :invites, source: "event", dependent: :destroy
	validates :name, presence: true, length: { maximum: 30 }
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }


	def self.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	def self.new_token
		SecureRandom.urlsafe_base64
	end

	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	def authenticated(token)
		BCrypt::Password.new(remember_digest).is_password?(token)
	end

	def forget
		update_attribute(:remember_digest, nil)
	end

	def upcoming_events
		self.attended_events.where("date > ?", DateTime.now).order("date ASC")
	end

	def previous_events
		self.attended_events.where("date < ?", DateTime.now).order("date ASC")
	end
end
