require 'rails_helper'

RSpec.describe Feature, type: :model do
  describe 'associations' do
    it { should have_many(:user_features) }
    it { should have_many(:users).through(:user_features) }
  end
end