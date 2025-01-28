class User < ApplicationRecord

  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable,
          :registerable,
          :recoverable,
          :validatable,
          :jwt_authenticatable,
          jwt_revocation_strategy: self

  has_many :user_features
  has_many :features, through: :user_features
  has_many :project_users
  has_many :projects, through: :project_users

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
        role: self.role,
        name: self.name,
        id: self.id,
      })
    end
end







