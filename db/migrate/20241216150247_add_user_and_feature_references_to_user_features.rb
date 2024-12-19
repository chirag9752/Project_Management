class AddUserAndFeatureReferencesToUserFeatures < ActiveRecord::Migration[7.1]
  def change
    add_reference :user_features, :user, foreign_key: true
    add_reference :user_features, :feature, foreign_key: true
  end
end
