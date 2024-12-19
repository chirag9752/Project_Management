class RenameTypeToEmployeeTypeInUsers < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :type, :employee_type
  end
end
