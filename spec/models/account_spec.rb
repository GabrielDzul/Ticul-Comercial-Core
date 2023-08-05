require 'rails_helper'

RSpec.describe Account, type: :model do
  subject { FactoryBot.create(:account) }

  it 'has a valid Factory' do
    is_expected.to be_valid
  end

  context 'validations' do
    it do
      is_expected.to validate_presence_of(:status)
      is_expected.to define_enum_for(:status).
        with_values(
          inactive: Attributes::AccountStatus::INACTIVE,
          active: Attributes::AccountStatus::ACTIVE,
          blocked: Attributes::AccountStatus::BLOCKED
        ).backed_by_column_of_type(:string).
        with_suffix
    end
  end

  context 'associations' do
    it 'works' do
      is_expected.to belong_to(:user)
    end
  end
end
