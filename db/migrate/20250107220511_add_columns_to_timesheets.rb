class AddColumnsToTimesheets < ActiveRecord::Migration[7.1]
  def change
    add_reference :timesheets, :user, foreign_key: true
    add_reference :timesheets, :project, foreign_key: true
    add_column :timesheets, :week_start_date, :date, null: false
    add_column :timesheets, :week_end_date, :date, null: false
    add_column :timesheets, :monday_hours, :float, default: 0
    add_column :timesheets, :tuesday_hours, :float, default: 0
    add_column :timesheets, :wednesday_hours, :float, default: 0
    add_column :timesheets, :thursday_hours, :float, default: 0
    add_column :timesheets, :friday_hours, :float, default: 0
    add_column :timesheets, :saturday_hours, :float, default: 0
    add_column :timesheets, :sunday_hours, :float, default: 0
  end
end



# create_table "timesheets", force: :cascade do |t|
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.float "total_hours", default: 0.0
#   t.string "status", default: "pending"
# end
