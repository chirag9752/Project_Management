require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  let(:user) { create(:user) }
  let(:project) { create(:project) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    let!(:projects) { create_list(:project, 2) }

    it 'returns a successful response' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'returns the correct JSON structure' do
      get :index
      json_response = JSON.parse(response.body)['data']
      expect(json_response.size).to eq(2)
      expect(json_response[0]).to have_key('id')
      expect(json_response[0]).to have_key('name')
      expect(json_response[0]).to have_key('billing_rate')
      expect(json_response[0]).to have_key('project_users')
    end

    it 'includes project users in the response' do
      project_user = create(:project_user, project: projects.first, user: user)
      get :index
      json_response = JSON.parse(response.body)['data'][0]
      expect(json_response['project_users'].size).to eq(1)
      expect(json_response['project_users'][0]['user_id']).to eq(project_user.user_id)
    end
  end

  describe 'GET #show' do
    let!(:project_with_users) { create(:project) }
    let!(:project_user) { create(:project_user, project: project_with_users, user: user) }

    it 'returns a successful response' do
      get :show, params: { id: project_with_users.id }
      expect(response).to have_http_status(:ok)
    end

    it 'returns the correct project details in JSON' do
      get :show, params: { id: project_with_users.id }
      json_response = JSON.parse(response.body)['data']
      expect(json_response).to have_key('id')
      expect(json_response).to have_key('name')
      expect(json_response).to have_key('billing_rate')
      expect(json_response).to have_key('project_users')
      expect(json_response['project_users'][0]).to have_key('user_id')
    end

    it 'returns users associated with the project' do
      get :show, params: { id: project_with_users.id }
      json_response = JSON.parse(response.body)['data']
      expect(json_response['users']).to be_an(Array)
      expect(json_response['users'][0]).to have_key('id')
      expect(json_response['users'][0]).to have_key('name')
      expect(json_response['users'][0]).to have_key('email')
    end
  end
end
