class AddUserToEvents < ActiveRecord::Migration[5.1]
  def change
    add_reference :events, :host, foreign_key: { to_table: :users }
  end
end
