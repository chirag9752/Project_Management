class ProjectUser < ApplicationRecord
  belongs_to :project
  belongs_to :user
  belongs_to :profile
  has_many :timesheets
end
  