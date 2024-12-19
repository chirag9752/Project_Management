class ChangeDefaultRoleAndEmployeeTypeInUsers < ActiveRecord::Migration[7.1]
  def change
    change_column_default :users, :role, from: 2, to: nil
    change_column_default :users, :employee_type, from: 2, to: nil
    change_column_null :users, :role, true
    change_column_null :users, :employee_type, true
  end
end
