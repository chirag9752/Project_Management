class ChangeTypeToAllowNullInUsers < ActiveRecord::Migration[7.1]
  def change
    change_column_null :users, :type, true
  end
end
