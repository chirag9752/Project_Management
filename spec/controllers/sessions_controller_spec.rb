require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do
  let(:user) { create(:user) }
  let(:jwt_token) { Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first }
  let(:authorization_header) { { 'Authorization' => "Bearer #{jwt_token}" } }

  before do
    request.headers.merge!(authorization_header)
  end

  describe 'POST #respond_with' do
    it 'responds with a valid JWT token and user data' do
      allow(request.env).to receive(:[]).with('warden-jwt_auth.token').and_return(jwt_token)
      
      post :respond_with, params: {}, format: :json
      
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)

      expect(json_response['token']).to eq(jwt_token)
      expect(json_response['data']).to have_key('user')
    end
  end

  describe 'DELETE #respond_to_on_destroy' do
    context 'when the user is logged in' do
      it 'returns an empty response with status :ok' do
        allow(controller).to receive(:check_current_user).and_return(user)

        delete :respond_to_on_destroy, params: {}, format: :json

        expect(response).to have_http_status(:ok)
        expect(response.body).to eq('{}')
      end
    end

    context 'when no active session exists' do
      it 'returns an error response with status :unauthorized' do
        allow(controller).to receive(:check_current_user).and_return(nil)

        delete :respond_to_on_destroy, params: {}, format: :json

        expect(response).to have_http_status(:unauthorized)
        json_response = JSON.parse(response.body)
        expect(json_response['status']).to eq(401)
        expect(json_response['error']).to eq("Couldn't find an active session.")
      end
    end
  end

  describe 'Private method #check_current_user' do
    context 'when Authorization header is present and valid' do
      it 'returns the current user' do
        user_from_method = controller.send(:check_current_user)
        expect(user_from_method).to eq(user)
      end
    end

    context 'when Authorization header is missing or invalid' do
      it 'returns nil' do
        request.headers['Authorization'] = nil
        user_from_method = controller.send(:check_current_user)
        expect(user_from_method).to be_nil
      end
    end
  end
end
