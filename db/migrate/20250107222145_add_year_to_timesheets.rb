class AddYearToTimesheets < ActiveRecord::Migration[7.1]
  def change
    add_column :timesheets, :year, :integer, null: false, default: 0
  end
end
