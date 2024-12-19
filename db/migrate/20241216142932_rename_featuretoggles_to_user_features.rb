class RenameFeaturetogglesToUserFeatures < ActiveRecord::Migration[7.1]
  def change
    rename_table :feature_toggles, :user_features
  end
end
