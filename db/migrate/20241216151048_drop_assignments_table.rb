class DropAssignmentsTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :assignments
  end
end
