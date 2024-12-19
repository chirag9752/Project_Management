class CreateJwtDenylists < ActiveRecord::Migration[7.1]
  def change
    create_table :jwt_denylists do |t|
      # unique identifier for jwt token 
      t.string :jti, null: false

      # Expiration time of the token
      t.datetime :exp, null: false
      t.timestamps
    end

    # add index for fast searching
     add_index :jwt_denylists, :jti, unique: true
  end
end
