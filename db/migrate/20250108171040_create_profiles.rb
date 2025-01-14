class CreateProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :profiles do |t|
      t.string :profile_name

      t.timestamps
    end
  end
end
