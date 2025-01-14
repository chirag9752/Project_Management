class AddTotalHoursAndStatusToTimesheets < ActiveRecord::Migration[7.1]
  def change
    add_column :timesheets, :total_hours, :float, default: 0
    add_column :timesheets, :status, :string, default: 'pending'
  end
end
