require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'associations' do
    it { should have_many(:project_users).dependent(:destroy) }
  end
end