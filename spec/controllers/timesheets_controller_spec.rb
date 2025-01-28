require 'rails_helper'

RSpec.describe TimesheetsController, type: :controller do
  let(:user) { create(:user) }
  let(:profile) { create(:profile) }
  let(:project) { create(:project) }
  let(:project_user) { create(:project_user, user: user, profile: profile, project: project) }
  let(:timesheet) { create(:timesheet, project_user: project_user, week_start_date: '2025-01-22') }

  before do
    sign_in user
  end

  describe 'GET #fetch_single_timesheet' do
    context 'when timesheet exists' do

      let(:valid_params) do
        {
          WeekData: {
            profile_Id: profile.id,
            project_Id: project.id,
            week_start_date: '2025-01-22'
          },
          featureknown: {
            userid: user.id
          }
        }
      end

      it 'returns the timesheet with status 200' do
        timesheet
        get :fetch_single_timesheet, params: valid_params
 
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response['timesheet']['id']).to eq(timesheet.id)
      end
    end

    context 'when timesheet does not exist' do
      let(:invalid_params) do
        {
          WeekData: {
            profile_Id: profile.id,
            project_Id: project.id,
            week_start_date: '2025-01-29'
          },
          featureknown: {
            userid: user.id
          }
        }
      end

      it 'returns an empty JSON object with status 200' do
        get :fetch_single_timesheet, params: invalid_params
        
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response).to eq({})
      end
    end

    context 'When required paramters are missing' do
      it 'returns an empty json object with status 200' do
        post :fetch_single_timesheet , params: {}

        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response).to eq({})
      end
    end
  end
end