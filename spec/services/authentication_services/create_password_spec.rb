require 'rails_helper'

describe AuthenticationServices::CreatePassword, type: :service do
  describe 'works when valid current and new password' do
    let(:user) { create(:complete_user) }
    let(:password) { 'h3LL0_w0rld!' }

    subject(:updated_user) do
      described_class.new.execute(
        user,
        password: password,
        password_confirmation: password
      )
    end

    it do
      expect(updated_user).to be_instance_of User
      expect(updated_user.user_credential).to be_instance_of UserCredential
      expect(updated_user.user_credential.password_digest).not_to be_nil
    end
  end

  describe 'fails when invalid password' do
    let(:user) { create(:complete_user) }
    let(:password) { 'hello' }

    subject(:updated_user) do
      described_class.new.execute(
        user,
        password: password,
        password_confirmation: password
      )
    end

    it do
      expect { updated_user }.to raise_error ActiveRecord::RecordInvalid
    end
  end

  describe 'fails when user already has password' do
    let(:user) { create(:complete_user_with_credential) }
    let(:password) { 'h3LL0_w0rld!' }

    subject(:updated_user) do
      described_class.new.execute(
        user,
        password: password,
        password_confirmation: password
      )
    end

    it do
      expect { updated_user }.to raise_error Error::User::InvalidCredentials
    end
  end
end
