class AddJtiToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :jti, :string
    add_index :users, :jti, unique: true # Add unique index for jti
  end
end
