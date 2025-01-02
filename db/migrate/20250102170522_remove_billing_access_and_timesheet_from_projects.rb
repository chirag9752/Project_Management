class RemoveBillingAccessAndTimesheetFromProjects < ActiveRecord::Migration[7.1]
  def change
    remove_column :projects, :billing_access, :boolean
    remove_column :projects, :timesheet, :boolean
  end
end
