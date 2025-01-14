class RenameTimeSheetsToTimesheets < ActiveRecord::Migration[7.1]
  def change
    rename_table :time_sheets, :timesheets
  end
end
