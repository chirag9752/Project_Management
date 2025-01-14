class AddDescriptionToTimesheets < ActiveRecord::Migration[7.1]
  def change
    add_column :timesheets, :description, :text
  end
end
