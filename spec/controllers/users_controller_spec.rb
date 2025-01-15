require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  # Setup user authentication and data
  let(:hr_user) { create(:user, role: :HR) }
  let(:normal_user) { create(:user, role: :developer) }
  let!(:user) { create(:user) }
  let!(:project) { create(:project) }
  let!(:user_project) { create(:project_user, user: user, project: project) }

  # Authenticate the user before running each test
  before do
    sign_in hr_user # Sign in the HR user for most tests
  end


  describe 'GET #index' do
    it 'returns all users' do
      get :index
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)['data']
      expect(json_response.size).to eq(User.count)
    end
  end

  describe 'GET #show' do
    it 'returns the user by ID' do
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)['data']
      expect(json_response['id']).to eq(user.id)
    end
  end

  describe 'GET #detailsshow' do
    it 'returns the user details and associated projects' do
      get :detailsshow, params: { id: user.id }
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      
      expect(json_response['data']['id']).to eq(user.id)
      expect(json_response['projects'].size).to eq(user.projects.size)
      expect(json_response['projects'][0]['id']).to eq(project.id)
    end
  end
end
