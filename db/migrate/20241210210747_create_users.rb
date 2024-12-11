class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, null: false
      t.string :password
      t.integer :role
      t.string :developer_type
      t.timestamps
    end
  end
end
