# require 'rails_helper'

# RSpec.describe TimesheetService do
#   let(:user) { create(:user) }
#   let(:profile) { create(:profile) }
#   let(:project) { create(:project) }
#   let(:project_user) { create(:project_user, user: user, profile: profile, project: project) }
#   let(:week_start_date) { Date.current.beginning_of_week }
  
#   let(:valid_params) do
#     {
#       "WeekData" => {
#         "profile_Id" => profile.id,
#         "project_Id" => project.id,
#         "week_start_date" => week_start_date,
#         "Description" => "Weekly timesheet entry",
#         "Hours" => {
#           "Monday" => "8",
#           "Tuesday" => "8",
#           "Wednesday" => "8",
#           "Thursday" => "8",
#           "Friday" => "8"
#         }
#       },
#       "featureknown" => {
#         "userid" => user.id
#       }
#     }
#   end

#   subject { described_class.new(valid_params) }

#   describe '#call' do
#     context 'when creating a new timesheet' do
#       it 'creates a new timesheet with correct attributes' do
#         expect { subject.call }.to change(Timesheet, :count).by(1)
        
#         result = subject.call
#         expect(result[:success]).to be true
#         expect(result[:message]).to eq("Timesheet created successfully")
        
#         timesheet = result[:data]
#         expect(timesheet).to have_attributes(
#           project_user_id: project_user.id,
#           week_start_date: week_start_date,
#           total_hours: 40,
#           status: "new",
#           description: "Weekly timesheet entry",
#           year: week_start_date.year
#         )
        
#         expect(timesheet.daily_hours).to eq({
#           "monday" => 8,
#           "tuesday" => 8,
#           "wednesday" => 8,
#           "thursday" => 8,
#           "friday" => 8
#         })
#       end
#     end

#     context 'when updating an existing timesheet' do
#       let!(:existing_timesheet) do
#         create(:timesheet,
#           project_user: project_user,
#           week_start_date: week_start_date,
#           status: "new",
#           total_hours: 32
#         )
#       end

#       it 'updates the existing timesheet' do
#         expect { subject.call }.not_to change(Timesheet, :count)
        
#         result = subject.call
#         expect(result[:success]).to be true
#         expect(result[:message]).to eq("Timesheet updated successfully")
        
#         existing_timesheet.reload
#         expect(existing_timesheet).to have_attributes(
#           total_hours: 40,
#           status: "updated"
#         )
#       end
#     end

#     context 'when project_user is not found' do
#       let(:invalid_params) do
#         valid_params.tap do |params|
#           params["WeekData"]["profile_Id"] = -1
#         end
#       end

#       subject { described_class.new(invalid_params) }

#       it 'returns an error' do
#         result = subject.call
#         expect(result[:success]).to be false
#         expect(result[:error]).to eq("Failed to save timesheet")
#       end
#     end

#     context 'when timesheet is invalid' do
#       before do
#         allow_any_instance_of(Timesheet).to receive(:save).and_return(false)
#         allow_any_instance_of(Timesheet).to receive_message_chain(:error, :full_messages).and_return(["Invalid timesheet"])
#       end

#       it 'returns error messages' do
#         result = subject.call
#         expect(result[:success]).to be false
#         expect(result[:error]).to eq("Failed to save timesheet")
#         expect(result[:details]).to eq(["Invalid timesheet"])
#       end
#     end
#   end

#   describe '#fetch_timesheet_params' do
#     it 'transforms hours data correctly' do
#       result = subject.send(:fetch_timesheet_params)
#       expect(result.daily_hours.keys).to all(be_a(String))
#       expect(result.daily_hours.values).to all(be_a(Integer))
#     end

#     it 'calculates total hours correctly' do
#       result = subject.send(:fetch_timesheet_params)
#       expect(result.total_hours).to eq(40)
#     end

#     context 'when project_user is not found' do
#       let(:invalid_params) do
#         valid_params.tap do |params|
#           params["WeekData"]["profile_Id"] = -1
#         end
#       end

#       subject { described_class.new(invalid_params) }

#       it 'returns error hash' do
#         result = subject.send(:fetch_timesheet_params)
#         expect(result).to eq({ success: false, errors: "something wrong with projects or profile" })
#       end
#     end
#   end
# end