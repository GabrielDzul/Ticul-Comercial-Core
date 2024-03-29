require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:complete_user) }
  subject { user }

  it 'has a valid Factory' do
    expect(subject).to be_valid
  end

  it 'associations' do
    is_expected.to have_one :user_credential
  end

  it 'validations' do
    is_expected.to validate_uniqueness_of(:activation_code)
    is_expected.to validate_uniqueness_of(:email).case_insensitive
    is_expected.to validate_presence_of(:status)
    is_expected.to define_enum_for(:status).
      with_values(
        incomplete: Attributes::UserStatus::INCOMPLETE,
        complete: Attributes::UserStatus::COMPLETE
      ).backed_by_column_of_type(:string).with_suffix
    is_expected.not_to allow_value(nil).for(:email)
    is_expected.not_to allow_values('not an email').for(:email)
    is_expected.to allow_value(nil).for(:activation_code)
    is_expected.to allow_value('+529971120789').for(:phone)
    is_expected.to allow_value(nil).for(:phone)
    is_expected.not_to allow_value('+909971120789').for(:phone)
  end

  context 'email_confirmed?' do
    it 'when activation code is nil and activation date is present is TRUE' do
      user = build(:user, activation_code: nil, activation_date: Time.now)
      expect(user.email_confirmed?).to be_truthy
    end

    it 'when activation code is present and activation date is nil is FALSE' do
      user = build(:user, activation_code: 'some-code', activation_date: nil)
      expect(user.email_confirmed?).to be_falsey
    end

    it 'when activation code is present and activation date is present' do
      user = build(:user, activation_code: 'some-code', activation_date: Time.now)
      expect(user.email_confirmed?).to be_falsey
    end

    it 'when activation code is nil and activation date is nil' do
      user = build(:user, activation_code: nil, activation_date: nil)
      expect(user.email_confirmed?).to be_falsey
    end
  end
end
