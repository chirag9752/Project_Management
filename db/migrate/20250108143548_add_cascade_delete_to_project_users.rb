class AddCascadeDeleteToProjectUsers < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :project_users, :projects

    # Add a new foreign key with ON DELETE CASCADE
    add_foreign_key :project_users, :projects, on_delete: :cascade
  end
end
