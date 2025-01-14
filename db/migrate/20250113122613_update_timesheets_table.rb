class UpdateTimesheetsTable < ActiveRecord::Migration[7.1]
  def change
    remove_column :timesheets, :week_end_date, :date
    remove_column :timesheets, :monday_hours, :float
    remove_column :timesheets, :tuesday_hours, :float
    remove_column :timesheets, :wednesday_hours, :float
    remove_column :timesheets, :thursday_hours, :float
    remove_column :timesheets, :friday_hours, :float
    remove_column :timesheets, :saturday_hours, :float
    remove_column :timesheets, :sunday_hours, :float

    # Add a profile_id column to associate with profiles table
    add_reference :timesheets, :project_user, foreign_key: true

    # Add a daily_hours column to store daily hours in JSONB format
    add_column :timesheets, :daily_hours, :jsonb, default: {}, null: false
  end
end
