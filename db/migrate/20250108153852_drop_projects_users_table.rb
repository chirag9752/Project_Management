class DropProjectsUsersTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :projects_users
  end
end
