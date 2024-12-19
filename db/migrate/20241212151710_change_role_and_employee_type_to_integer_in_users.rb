class ChangeRoleAndEmployeeTypeToIntegerInUsers < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :role, :integer, default: 2, using: "role::integer"
    change_column :users, :employee_type, :integer, default: 2, using: "employee_type::integer"
  end
end
