require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do
  include Devise::Test::ControllerHelpers

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  let(:user) { create(:user, email: 'test@example.com', password: 'password123') }

  describe 'POST #create' do
    context 'with valid credentials' do
      before do
        @request.env['HTTP_ACCEPT'] = 'application/json'
        post :create, params: {
          user: {
            email: user.email,
            password: 'password123'
          }
        }, format: :json
      end

      it 'returns successful response' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns JWT token' do
        json_response = JSON.parse(response.body)
        expect(json_response['status']['token']).to be_present
      end

      it 'returns success message' do
        json_response = JSON.parse(response.body)
        expect(json_response['status']['message']).to eq('Logged in successfully.')
      end

      it 'returns user data' do
        json_response = JSON.parse(response.body)
        expect(json_response['status']['data']['user']).to include('email' => user.email)
      end
    end

    context 'with invalid credentials' do
      before do
        post :create, params: {
          user: {
            email: user.email,
            password: 'wrong_password'
          }
        }, format: :json
      end

      it 'returns unauthorized status' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when user is logged in' do
      let(:token) { generate_jwt_token_for(user) }

      before do
        request.headers['Authorization'] = "Bearer #{token}"
        delete :destroy, format: :json
      end

      it 'returns successful response' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns success message' do
        json_response = JSON.parse(response.body)
        expect(json_response['message']).to eq('Logged out successfully.')
      end
    end

    context 'when user is not logged in' do
      before do
        delete :destroy, format: :json
      end

      it 'returns unauthorized status' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns error message' do
        json_response = JSON.parse(response.body)
        expect(json_response['message']).to eq("Couldn't find an active session.")
      end
    end
  end
end

# Add this helper method in your rails_helper.rb or in a support file
def generate_jwt_token_for(user)
  JWT.encode(
    { sub: user.id, exp: 24.hours.from_now.to_i },
    Rails.application.credentials.devise_jwt_secret_key!
  )
end