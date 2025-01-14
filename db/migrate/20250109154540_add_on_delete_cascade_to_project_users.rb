class AddOnDeleteCascadeToProjectUsers < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :project_users, :profiles

    # Add a new foreign key with ON DELETE CASCADE
    add_foreign_key :project_users, :profiles, on_delete: :cascade
  end
end
