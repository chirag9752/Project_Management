class Project < ApplicationRecord
    # has_and_belongs_to_many :users
    has_many :time_sheets

    has_many :project_users
    has_many :users, through: :project_users
end
