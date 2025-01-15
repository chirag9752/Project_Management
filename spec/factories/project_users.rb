FactoryBot.define do
  factory :project_user do
    association :user
    association :profile
    association :project
  end
end