require 'rails_helper'

RSpec.describe Timesheet, type: :model do
  describe 'associations' do
    it { should belong_to(:project_user) }
  end
end