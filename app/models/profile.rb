class Profile < ApplicationRecord
  has_many :project_users, dependent: :destroy
end
