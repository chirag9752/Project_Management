class AddUniqueIndexToProfileNameInProfiles < ActiveRecord::Migration[7.1]
  def change
    add_index :profiles, :profile_name, unique: true
  end
end
