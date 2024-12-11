class CreateProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.decimal :billing_rate, precision: 10, scale: 2
      t.references :users, null: false, foreign_key: true
      t.timestamps
    end
  end
end
