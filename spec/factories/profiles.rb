FactoryBot.define do
  factory :profile do
    sequence(:profile_name) { |n| "Profile #{n}" }
    # Add other necessary attributes
  end
end