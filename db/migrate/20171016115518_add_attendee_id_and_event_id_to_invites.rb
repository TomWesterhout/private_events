class AddAttendeeIdAndEventIdToInvites < ActiveRecord::Migration[5.1]
  def change
    add_reference :invites, :attendee, foreign_key: { to_table: :users }
    add_reference :invites, :event, foreign_key: { to_table: :events }
  end
end
