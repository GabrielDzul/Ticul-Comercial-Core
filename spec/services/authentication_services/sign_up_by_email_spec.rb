require 'rails_helper'

describe AuthenticationServices::SignUpByEmail, type: :service do

  context 'works' do
    it 'when email is not registered and passwords match' do
      # Given
      service = described_class.new
      email = 'hola@waifu.com'
      password = 'pA$sW0rd'
      password_confirmation = 'pA$sW0rd'

      # When
      subject = service.execute(email: email, password: password, password_confirmation: password_confirmation)

      expect { subject }.not_to raise_error
      expect(subject).to be_an_instance_of User
      expect(subject.email).to eq email
      expect(subject.activation_code).not_to be_nil
      expect(subject.user_credential.password_digest).to be_truthy
    end
  end

  context 'Fails' do
    it 'when email is already registered' do
      # Given
      service = described_class.new
      email = 'hola@waifu.com'
      password = 'pA$sW0rd'
      password_confirmation = 'pA$sW0rd'
      create(:complete_user, email: email)

      # When/Then
      expect { service.execute(email: email, password: password, password_confirmation: password_confirmation) }.to raise_error Error::User::EmailAlreadyRegistered
    end

    it 'when password and password_confirmation do not match' do
      # Given
      service = described_class.new
      email = 'hola@waifu.com'
      password = 'pA$sW0rd'
      password_confirmation = 'pA$sW0rD'

      # When/Then
      expect { service.execute(email: email, password: password, password_confirmation: password_confirmation) }.to raise_error ActiveRecord::RecordInvalid
    end

    it 'when the email is not valid' do
      # Given
      service = described_class.new
      email = 'hola@waifu.'
      password = 'pA$sW0rd'
      password_confirmation = 'pA$sW0rd'

      # When/Then
      expect { service.execute(email: email, password: password, password_confirmation: password_confirmation) }.to raise_error ActiveRecord::RecordInvalid
    end
  end
end
