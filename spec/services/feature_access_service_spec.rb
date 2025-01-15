require 'rails_helper'

RSpec.describe FeatureAccessService, type: :service do
  describe '.has_access?' do
    let(:user) { create(:user) }
    let(:feature) { create(:feature) }
    
    context 'when feature_name is blank' do
      it 'returns false' do
        result = FeatureAccessService.has_access?(user, '')
        expect(result).to eq(false)
      end
    end
    
    # context 'when feature does not exist' do
    #   it 'returns false' do
    #     non_existent_feature_name = "NonExistentFeature"
    #     result = FeatureAccessService.has_access?(user, non_existent_feature_name)
    #     expect(result).to eq(false)
    #   end
    # end

    # context 'when feature exists but user does not have access' do
    #   it 'returns false' do
    #     result = FeatureAccessService.has_access?(user, feature.feature_name)
    #     expect(result).to eq(false)
    #   end
    # end

    # context 'when user has access to the feature' do
    #   before do
    #     user.features << feature
    #   end

    #   it 'returns true' do
    #     result = FeatureAccessService.has_access?(user, feature.feature_name)
    #     expect(result).to eq(true)
    #   end
    # end
  end
end
