require 'rails_helper'

RSpec.describe ProjectUser, type: :model do
  describe 'associations' do
    it { should belong_to(:project) }
    it { should belong_to(:user) }
    it { should belong_to(:profile) }
    it { should have_many(:timesheets) }
  end
end