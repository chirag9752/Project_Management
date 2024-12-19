class AddJwtRevocationTokenToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :jwt_revocation_token, :string
  end
end
