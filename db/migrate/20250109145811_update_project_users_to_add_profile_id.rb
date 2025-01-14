class UpdateProjectUsersToAddProfileId < ActiveRecord::Migration[7.1]
  def change
    remove_column :project_users, :profile_name, :string

    # Add the profile_id column
    add_column :project_users, :profile_id, :bigint, null: false

    # Add foreign key constraint to link profile_id to profiles table
    add_foreign_key :project_users, :profiles, column: :profile_id
  end
end
