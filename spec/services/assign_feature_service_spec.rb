require 'rails_helper'

RSpec.describe AssignFeatureService do
  let(:user) { create(:user) }
  let(:feature) { create(:feature) }

  describe '#call' do
    context 'when user and feature are valid' do
      it 'assigns the feature to the user' do
        service = AssignFeatureService.new(assign_feature: { user_id: user.id, feature_name: feature.feature_name })
        result = service.call

        expect(result[:success]).to eq(true)
        expect(result[:message]).to eq('Feature assigned successfully')
        expect(user.features).to include(feature)
      end

      it 'returns an error if the feature is already assigned' do
        user.features << feature # Assign the feature first
        service = AssignFeatureService.new(assign_feature: { user_id: user.id, feature_name: feature.feature_name })
        result = service.call

        expect(result[:success]).to eq(false)
        expect(result[:errors]).to eq('Feature already assigned')
      end
    end

    context 'when user or feature is invalid' do
      it 'returns an error if the user is not found' do
        invalid_user_id = 9999
        service = AssignFeatureService.new(assign_feature: { user_id: invalid_user_id, feature_name: feature.feature_name })
        result = service.call

        expect(result[:success]).to eq(false)
        expect(result[:errors]).to eq('Invalid user or feature')
      end

      it 'returns an error if the feature is not found' do
        invalid_feature_name = "Nonexistent Feature"
        service = AssignFeatureService.new(assign_feature: { user_id: user.id, feature_name: invalid_feature_name })
        result = service.call

        expect(result[:success]).to eq(false)
        expect(result[:errors]).to eq('Invalid user or feature')
      end
    end
  end
end
