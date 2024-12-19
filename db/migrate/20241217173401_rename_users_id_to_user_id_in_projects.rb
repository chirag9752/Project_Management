class RenameUsersIdToUserIdInProjects < ActiveRecord::Migration[7.1]
  def change
    rename_column :projects, :users_id, :user_id
  end
end
