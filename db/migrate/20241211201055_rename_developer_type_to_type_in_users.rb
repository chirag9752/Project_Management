class RenameDeveloperTypeToTypeInUsers < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :developer_type, :type
  end
end
