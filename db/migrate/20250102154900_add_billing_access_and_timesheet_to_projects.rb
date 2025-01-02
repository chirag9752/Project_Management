class AddBillingAccessAndTimesheetToProjects < ActiveRecord::Migration[7.1]
  def change
    add_column :projects, :billing_access, :boolean, default: false, null: false
    add_column :projects, :timesheet, :boolean, default: false, null: false
  end
end
