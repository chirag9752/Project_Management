class Assignment < ApplicationRecord
    belongs_to :User
    belongs_to :project
end
