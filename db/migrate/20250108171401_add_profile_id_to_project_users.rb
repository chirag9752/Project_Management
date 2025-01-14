class AddProfileIdToProjectUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :project_users, :profile_id, :bigint
    add_foreign_key :project_users, :profiles, column: :profile_id
  end
end
