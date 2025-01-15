# require 'rails_helper'

# RSpec.describe Hr::FeaturesController, type: :controller do
#   let(:hr_user) { create(:user, role: :HR) }
#   let(:user) { create(:user) }
#   let(:feature) { create(:feature) }
#   let(:params) do
#     {
#       featureknown: {
#         userid: user.id,
#         feature_name: feature.feature_name
#       }
#     }
#   end

#   before do
#     sign_in hr_user
#   end

#   describe 'GET #index' do
#     it 'returns all features' do
#       create_list(:feature, 5)
#       get :index
#       expect(response).to have_http_status(:ok)
#       json_response = JSON.parse(response.body)['data']
#       expect(json_response.size).to eq(5)
#     end
#   end

#   describe 'POST #execute' do
#     it 'executes the feature service successfully' do
#       allow_any_instance_of(SomeFeatureService).to receive(:call).and_return({ success: true, message: "Feature executed", data: {} })
      
#       post :execute, params: params
#       expect(response).to have_http_status(:created)
#       json_response = JSON.parse(response.body)
#       expect(json_response['status']['code']).to eq(201)
#       expect(json_response['status']['message']).to eq('Feature executed')
#     end

#     it 'returns error when feature is not implemented' do
#       params[:featureknown][:feature_name] = 'non_existent_feature'
#       post :execute, params: params
#       expect(response).to have_http_status(:forbidden)
#       json_response = JSON.parse(response.body)
#       expect(json_response['errors']).to include("Feature non_existent_feature not implemented")
#     end
#   end

#   describe 'POST #checking_user_feature' do
#     it 'returns allowed features for the user' do
#       user.features << feature
#       post :checking_user_feature, params: { userid: user.id }
#       expect(response).to have_http_status(:ok)
#       json_response = JSON.parse(response.body)
#       expect(json_response['allowed_features']).to include(feature.feature_name)
#     end

#     it 'returns error if user not found' do
#       post :checking_user_feature, params: { userid: -1 }
#       expect(response).to have_http_status(:not_found)
#       json_response = JSON.parse(response.body)
#       expect(json_response['error']).to eq("User not found")
#     end

#     it 'returns error if user is unauthorized' do
#       sign_in create(:user)  # Signing in as a non-authorized user
#       post :checking_user_feature, params: { userid: user.id }
#       expect(response).to have_http_status(:forbidden)
#       json_response = JSON.parse(response.body)
#       expect(json_response['error']).to eq("You are not authorized to access this request")
#     end
#   end
# end
