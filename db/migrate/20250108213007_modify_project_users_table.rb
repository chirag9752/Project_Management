class ModifyProjectUsersTable < ActiveRecord::Migration[7.1]
  def change
    # Remove the foreign key and the profile_id column
    remove_foreign_key :project_users, :profiles if foreign_key_exists?(:project_users, :profiles)
    remove_column :project_users, :profile_id, :bigint

    # Add the project_name column
    add_column :project_users, :profile_name, :string, null: false
  end
end
