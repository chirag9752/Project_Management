require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:user_features) }
    it { should have_many(:features).through(:user_features) }
    it { should have_many(:project_users) }
    it { should have_many(:projects).through(:project_users) }
  end

  describe 'enums' do
    # it do
    #   should define_enum_for(:role)                       # provided by RSpec::ActiveModel::Matchers
    #     .with_values(HR: 0, BD: 1, developer: 2)
    #     .backed_by_column_of_type(:integer)
    # end

    it 'define role as an enum' do
      expect(User.roles).to eq({"HR" => 0, "BD" => 1, "developer" => 2})
    end

    # it do
    #   should define_enum_for(:employee_type)
    #   .with_values(Manager: 1, TeamLead: 0, JuniorDeveloper: 2)
    #   .backed_by_column_of_type(:integer)
    # end

    it 'define employee_type as an enum' do
      expect(User.employee_types).to eq({"Manager" => 1, "TeamLead" => 0, "JuniorDeveloper" => 2})
    end
  end

  describe 'devise modules' do
    it 'includes devise modules' do
      expect(User.ancestors).to include(
        Devise::Models::DatabaseAuthenticatable,
        Devise::Models::Registerable,
        Devise::Models::Recoverable,
        Devise::Models::Validatable,
        Devise::JWT::RevocationStrategies::JTIMatcher
      )
    end
  end

  describe '#jwt_payload' do
    let(:user) { create(:user, role: 'developer', email: "John@example.com", password: "password", name: 'John Doe', id: 1) }
    it 'returns a hash with custom payload values' do
      payload = user.jwt_payload
      expect(payload).to include(
        role: 'developer',
        name: 'John Doe',
        id: 1
      )
    end
  end 
end