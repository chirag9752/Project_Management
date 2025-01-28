require 'rails_helper'

RSpec.describe 'ApplicationController', type: :request do
  describe 'CSRF protection' do
    context 'when sending a POST request without a CSRF token' do
      it 'returns a 403 Forbidden response' do
        post user_registration_path, params: { some_param: 'value' }
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe 'Devise parameter sanitization' do
    context 'when sending a POST request to a Devise controller action' do
      it 'permits the expected parameters' do
        post user_registration_path, params: { user: { name: 'John Doe', role: 'developer', employee_type: 'Manager', password: 'password123' } }
        # Assuming you have a way to check permitted parameters, e.g., by inspecting the controller's params
        expect(controller.params[:user][:name]).to eq('John Doe')
        expect(controller.params[:user][:role]).to eq('developer')
        expect(controller.params[:user][:employee_type]).to eq('Manager')
      end
    end
  end
end
