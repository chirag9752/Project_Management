class User < ApplicationRecord

  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable,     # Encrypt passwords
         :registerable,                 # Allow user registration
         :recoverable,                  # Reset password functionality
         :rememberable,                 # Remember user login
         :validatable,                  # Email and password validations
         :jwt_authenticatable,           # JWT authentication
          jwt_revocation_strategy: self  # Revocation strategy

    has_many :user_features
    has_many :features, through: :user_features
    has_many :projects
    has_many :time_sheets

    enum role: {
       HR: 0,
       BD: 1,
       developer: 2
    }

    enum employee_type: {
      Manager: 1,
      TeamLead: 0,
      JuniorDeveloper: 2
    }

    def jwt_payload
      super.merge({
        role: self.role
      })
    end

    def self.jwt_revoked?(payload, user)
      user.jwt_revocation_token = payload['jti']
    end

    def self.revoke_jwt(payload, user)
      user.update_column(:jwt_revocation_token, payload['jti'])
    end
end
