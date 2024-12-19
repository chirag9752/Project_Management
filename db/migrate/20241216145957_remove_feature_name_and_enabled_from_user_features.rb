class RemoveFeatureNameAndEnabledFromUserFeatures < ActiveRecord::Migration[7.1]
  def change
    remove_column :user_features, :feature_name, :string
    remove_column :user_features, :enabled, :boolean
  end
end
