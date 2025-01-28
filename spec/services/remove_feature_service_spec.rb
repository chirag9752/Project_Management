require 'rails_helper'

RSpec.describe RemoveFeatureService do
  let(:user) { create(:user) }
  let(:feature) { create(:feature) }

  describe '#call' do
    context 'when user and feature are valid' do
      it 'removes the feature from the user successfully' do
        user.features << feature
        service = RemoveFeatureService.new(assign_feature: { user_id: user.id, feature_name: feature.feature_name })
        result = service.call

        expect(result[:success]).to eq(true)
        expect(user.features).not_to include(feature)
      end

      it 'returns an error if the feature is not assigned to the user' do
        service = RemoveFeatureService.new(assign_feature: { user_id: user.id, feature_name: feature.feature_name })
        result = service.call

        expect(result[:success]).to eq(false)
        expect(result[:errors]).to eq("Feature is not assigned to user #{user.name}")
      end
    end

    context 'when user or feature is invalid' do
      it 'returns an error if the user is not found' do
        invalid_user_id = 9999
        service = RemoveFeatureService.new(assign_feature: { user_id: invalid_user_id, feature_name: feature.feature_name })
        result = service.call

        expect(result[:success]).to eq(false)
        expect(result[:errors]).to eq('Invalid user or feature')
      end

      it 'returns an error if the feature is not found' do
        invalid_feature_name = "Nonexistent Feature"
        service = RemoveFeatureService.new(assign_feature: { user_id: user.id, feature_name: invalid_feature_name })
        result = service.call

        expect(result[:success]).to eq(false)
        expect(result[:errors]).to eq('Invalid user or feature')
      end
    end
  end
end
