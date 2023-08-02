require 'rails_helper'

RSpec.describe UserCredential, type: :model do
  subject { FactoryBot.create(:user_credential) }

  it 'has a valid Factory' do
    expect(subject).to be_valid
  end

  it 'associations' do
    is_expected.to belong_to(:user)
  end

  it 'validations' do
    is_expected.to validate_confirmation_of(:password)
  end
end
