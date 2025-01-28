require 'rails_helper'

RSpec.describe Hr::FeaturesController, type: :controller do
  let(:user) { create(:user) }
	let(:other_user) { create(:user) }
	let(:feature) { create(:feature, feature_name: 'ExampleFeature') }

	before do
		sign_in user
	end

	describe 'GET #index' do
	  it 'returns all features with status 200' do
			feature
			get :index

			expect(response).to have_http_status(:ok)
			json_response = JSON.parse(response.body)
			expect(json_response['data'].size).to eq(Feature.count)
			expect(json_response['data'].first['feature_name']).to eq(feature.feature_name)  
		end
  end

	describe 'POST #execute' do
	  let(:valid_params) do
			{
				featureknown: {
					userid: user.id,
					feature_name: feature.feature_name
				}
			}
		end

		context "When the feature accessed is allowed" do
			it 'execute the feature and return the successfull response' do
				allow(FeatureAccessService).to receive(:has_access?).and_return(true)
				allow_any_instance_of(CallFeatureService).to receive(:call).and_return({ success: true, data: { result: 'Success'} })

				post :execute, params: valid_params

				expect(response).to have_http_status(:ok)
				json_response = JSON.parse(response.body)
				expect(json_response['data']['result']).to eq('Success')
			end
		end

		context "When feature access is denied" do
			it 'return a forbidden response' do
				allow(FeatureAccessService).to receive(:has_access?).and_return(false)
				post :execute, params: valid_params

				expect(response).to have_http_status(:forbidden)
				json_response = JSON.parse(response.body)
				expect(json_response['error']).to eq('Feature not enabled for this user')
			end
		end
  end
	
	describe 'Get #checking user feature' do
	  context 'when the user exist and is authorized' do
			let(:valid_params) {{ userid: user.id }}
      
			it 'return the allowed features for the user' do
        feature

				user.features << feature

				get :checking_user_feature, params: valid_params

				expect(response).to have_http_status(:ok)
				json_response = JSON.parse(response.body)
				expect(json_response['allowed_features']).to include(feature.feature_name)
			end
		end

		context 'when the user does not exist' do
      it 'returns a not found response' do
        get :checking_user_feature, params: { userid: 9999 }

        expect(response).to have_http_status(:not_found)
        parsed_body = JSON.parse(response.body)
        expect(parsed_body['error']).to eq('User not found')
      end
    end

		context 'when the user is not authorized' do
      it 'returns a forbidden response' do
        get :checking_user_feature, params: { userid: other_user.id }

        expect(response).to have_http_status(:forbidden)
        parsed_body = JSON.parse(response.body)
        expect(parsed_body['error']).to eq('You are not authorized to access this request')
      end
    end
  end
end