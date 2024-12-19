class RenameNameToFeatureNameInFeatures < ActiveRecord::Migration[7.1]
  def change
    rename_column :features, :name, :feature_name
  end
end
