require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]  #When you override Devise's default controllers (e.g., RegistrationsController), you need to explicitly set the mapping so that Devise can handle the resource correctly.
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) do
        {
          user: {
            email: 'test@example.com',
            password: 'password123',
            password_confirmation: 'password123'
          }
        }
      end

      it 'creates a new user' do
        expect {
          post :create, params: valid_params, format: :json
        }.to change(User, :count).by(1)
      end

      it 'returns successful response' do
        post :create, params: valid_params, format: :json

        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response['data']).to include('email' => valid_params[:user][:email])
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        {
          user: {
            email: 'invalid_email',
            password: 'short',
            password_confirmation: 'different'
          }
        }
      end

      it 'does not create a new user' do
        expect {
          post :create, params: invalid_params, format: :json
        }.not_to change(User, :count)
      end

      it 'returns error response' do
        post :create, params: invalid_params, format: :json
        
        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response['status']['message']).to include("User couldn't be created successfully")
      end
    end
  end
end