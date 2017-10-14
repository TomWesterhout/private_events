class AddDescriptionAndTimeToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :description, :string
    add_column :events, :time, :time
  end
end
