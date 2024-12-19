class RenameNameToProjectNameInProjects < ActiveRecord::Migration[7.1]
  def change
    rename_column :projects, :name, :project_name
  end
end
