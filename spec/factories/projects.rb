FactoryBot.define do
  factory :project do
    sequence(:project_name) { |n| "Project #{n}" }
    # Add other necessary attributes
  end
end