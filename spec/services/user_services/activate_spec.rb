require 'rails_helper'

describe 'UserServices::Activate', type: :service do
  let(:service) { UserServices::Activate.new }

  describe 'Activates a user when' do
    context 'user has activation code' do
      let!(:user) { create(:user, activation_code: SecureRandom.hex) }

      subject do
        service.execute(activation_code: user.activation_code)
      end

      it do
        expect(subject).to be_instance_of(User)
        expect(subject.activation_code).to be_nil
        expect(subject.activation_date).not_to be_nil
      end
    end
  end
end
