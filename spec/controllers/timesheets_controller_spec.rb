require 'rails_helper'

RSpec.describe TimesheetsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { create(:user) }
  let(:profile) { create(:profile) }
  let(:project) { create(:project) }
  let(:project_user) { create(:project_user, user: user, profile: profile, project: project) }
  let(:week_start_date) { Date.today.beginning_of_week }

  before do
    sign_in user
  end

  describe 'GET #fetch_single' do
    context 'when timesheet exists' do
      let!(:timesheet) do
        create(:timesheet, 
          project_user: project_user,
          week_start_date: week_start_date
        )
      end

      let(:valid_params) do
        {
          WeekData: {
            profile_Id: profile.id,
            project_Id: project.id,
            week_start_date: week_start_date
          },
          featureknown: {
            userid: user.id
          }
        }
      end

      it 'returns successful response with timesheet data' do
        get :fetch_single, params: valid_params
        
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response['message']).to eq('Timesheet fetched successfully')
        expect(json_response['timesheet']).to be_present
      end
    end

    context 'when timesheet does not exist' do
      # Create project_user but no timesheet
      let!(:project_user) { create(:project_user, user: user, profile: profile, project: project) }

      let(:params_without_timesheet) do
        {
          WeekData: {
            profile_Id: profile.id,
            project_Id: project.id,
            week_start_date: week_start_date
          },
          featureknown: {
            userid: user.id
          }
        }
      end

      it 'returns appropriate message when timesheet is empty' do
        get :fetch_single, params: params_without_timesheet
        
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response['message']).to eq('Timesheet is empty of this particular week please update it now!')
      end
    end

    context 'when user is not authenticated' do
      before do
        sign_out user
      end

      it 'returns unauthorized status' do
        get :fetch_single
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        {
          WeekData: {
            profile_Id: 999999,
            project_Id: 999999,
            week_start_date: week_start_date
          },
          featureknown: {
            userid: 999999
          }
        }
      end

      it 'handles missing project_user gracefully' do
        get :fetch_single, params: invalid_params
        
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response['message']).to eq('Timesheet is empty of this particular week please update it now!')
      end
    end
  end
end