FactoryBot.define do
  factory :timesheet do
    association :project_user
    week_start_date { Date.today.beginning_of_week }
  end
end