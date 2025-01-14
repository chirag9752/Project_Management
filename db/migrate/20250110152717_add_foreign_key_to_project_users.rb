class AddForeignKeyToProjectUsers < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :project_users, :profiles, column: :profile_id, primary_key: :id
  end
end
