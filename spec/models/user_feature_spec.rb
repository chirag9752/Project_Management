require 'rails_helper'

RSpec.describe UserFeature, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:feature) }
  end
end