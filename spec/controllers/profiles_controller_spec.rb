require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  describe 'GET #index' do
    context 'when profiles exist' do
      let!(:profiles) do
        [
          create(:profile, profile_name: 'Developer'),
          create(:profile, profile_name: 'Manager')
        ]
      end

      it 'returns all profiles successfully' do
        get :index

        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        
        expect(json_response['message']).to eq('Profile fetched successfully')
        expect(json_response['data'].length).to eq(2)
        expect(json_response['data'].map { |p| p['profile_name'] }).to include('Developer', 'Manager')
      end
    end

    context 'when no profiles exist' do
      before do
        Profile.destroy_all # Ensure no profiles exist
      end

      it 'returns an empty array with success message' do
        get :index

        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        
        expect(json_response['message']).to eq('Profile fetched successfully')
        expect(json_response['data']).to be_empty
      end
    end
  end
end