class RemoveForeignKeysFromTimesheets < ActiveRecord::Migration[7.1]
  def change
    remove_reference :timesheets, :user, foreign_key: true
    remove_reference :timesheets, :project, foreign_key: true
  end
end
