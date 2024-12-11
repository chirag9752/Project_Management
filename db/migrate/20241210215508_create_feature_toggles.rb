class CreateFeatureToggles < ActiveRecord::Migration[7.1]
  def change
    create_table :feature_toggles do |t|
      t.string :feature_name
      t.boolean :enabled
      t.timestamps
    end
  end
end
