# require 'rails_helper'

# RSpec.describe ProjectService, type: :service do
#   describe '#call' do
#     let(:user) { create(:user) }
#     let(:project1) { create(:project, user: user, project_name: 'Project 1', billing_rate: 100) }
#     let(:project2) { create(:project, user: user, project_name: 'Project 2', billing_rate: 200) }
#     let(:params) { { featureknown: { userid: user.id } } }

#     before do
#       create(:project_user, project: project1, user: user, billing_access: true, timesheet: false)
#       create(:project_user, project: project2, user: user, billing_access: false, timesheet: true)
#     end

#     context 'when the service is called with valid params' do
#       it 'returns a successful response with the projects data' do
#         service = ProjectService.new(params)
#         result = service.call

#         expect(result[:success]).to eq(true)
#         expect(result[:data].size).to eq(2) # Two projects for the user

#         # Check data for first project
#         project_data = result[:data].first
#         expect(project_data[:id]).to eq(project1.id)
#         expect(project_data[:name]).to eq('Project 1')
#         expect(project_data[:billing_rate]).to eq(100)

#         # Check project users for first project
#         project_user_data = project_data[:project_users].first
#         expect(project_user_data[:user_id]).to eq(user.id)
#         expect(project_user_data[:billing_access]).to eq(true)
#         expect(project_user_data[:timesheet]).to eq(false)

#         # Check data for second project
#         project_data = result[:data].last
#         expect(project_data[:id]).to eq(project2.id)
#         expect(project_data[:name]).to eq('Project 2')
#         expect(project_data[:billing_rate]).to eq(200)

#         # Check project users for second project
#         project_user_data = project_data[:project_users].first
#         expect(project_user_data[:user_id]).to eq(user.id)
#         expect(project_user_data[:billing_access]).to eq(false)
#         expect(project_user_data[:timesheet]).to eq(true)
#       end
#     end

#     context 'when the service is called with invalid user ID' do
#       let(:invalid_params) { { featureknown: { userid: nil } } }

#       it 'raises an error' do
#         service = ProjectService.new(invalid_params)
#         expect { service.call }.to raise_error(ActiveRecord::RecordNotFound)
#       end
#     end
#   end
# end
