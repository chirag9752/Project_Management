FactoryBot.define do
  factory :project do
    sequence(:project_name) { |n| "Project #{n}" }
  end
end