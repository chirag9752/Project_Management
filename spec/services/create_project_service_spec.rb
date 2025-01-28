# require 'rails_helper'

# RSpec.describe CreateProjectService, type: :service do
#   describe '#call' do
#     let(:valid_params) do
#       {
#         project: {
#           project_name: 'Test Project',
#           billing_rate: 100,
#           user_List: [
#             { "email" => "user1@example.com", "timesheet" => true, "billing_access" => true, "profile_name" => "Developer" },
#             { "email" => "user2@example.com", "timesheet" => false, "billing_access" => false, "profile_name" => "Manager" }
#           ]
#         }
#       }
#     end

#     let(:invalid_params) do
#       { project: { project_name: '', billing_rate: 100, user_List: [] } }
#     end

#     let(:user1) { create(:user, email: "user1@example.com") }
#     let(:user2) { create(:user, email: "user2@example.com") }

#     context 'when valid parameters are provided' do
#       before do
#         # Create a Profile for the test users if needed
#         create(:profile, profile_name: 'Developer')
#         create(:profile, profile_name: 'Manager')
#       end

#       it 'creates the project successfully' do
#         service = CreateProjectService.new(valid_params)
#         result = service.call

#         expect(result[:success]).to eq(true)
#         expect(result[:message]).to eq("Project created successfully")
#         expect(result[:data]).to be_a(Project)
#         expect(result[:data].project_name).to eq('Test Project')
#         expect(result[:data].project_users.count).to eq(2) # Two users should be added to project_users
#       end
#     end

#     context 'when no user emails are provided' do
#       let(:params_without_users) do
#         { project: { project_name: 'Test Project', billing_rate: 100, user_List: [] } }
#       end

#       it 'returns an error' do
#         service = CreateProjectService.new(params_without_users)
#         result = service.call

#         expect(result[:success]).to eq(false)
#         expect(result[:errors]).to include("No user emails provided")
#       end
#     end

#     context 'when no valid users are found' do
#       let(:params_with_invalid_user_emails) do
#         { project: { project_name: 'Test Project', billing_rate: 100, user_List: [{ "email" => "invalid_user@example.com", "timesheet" => true, "billing_access" => true, "profile_name" => "Developer" }] } }
#       end

#       it 'returns an error about invalid users' do
#         service = CreateProjectService.new(params_with_invalid_user_emails)
#         result = service.call

#         expect(result[:success]).to eq(false)
#         expect(result[:errors]).to include("No valid user found for the given emails")
#       end
#     end

#     context 'when profiles do not exist and new profiles are created' do
#       it 'creates a new profile and associates it with the project user' do
#         service = CreateProjectService.new(valid_params)
#         result = service.call

#         expect(result[:success]).to eq(true)
#         expect(Profile.exists?(profile_name: "Developer")).to be_truthy
#         expect(Profile.exists?(profile_name: "Manager")).to be_truthy

#         # Verify the created profiles are linked with the users
#         developer_profile = Profile.find_by(profile_name: "Developer")
#         manager_profile = Profile.find_by(profile_name: "Manager")
#         expect(result[:data].project_users.first.profile_id).to eq(developer_profile.id)
#         expect(result[:data].project_users.last.profile_id).to eq(manager_profile.id)
#       end
#     end

#     context 'when project parameters are invalid' do
#       it 'returns an error about invalid project parameters' do
#         service = CreateProjectService.new(invalid_params)
#         result = service.call

#         expect(result[:success]).to eq(false)
#         expect(result[:errors]).to include("Invalid project parameters")
#       end
#     end
#   end
# end