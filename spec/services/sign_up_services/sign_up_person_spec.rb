require 'rails_helper'

describe 'SignUpServices::SignUpPerson', type: :service do
  let(:service) { SignUpServices::SignUpPerson.new }
  let(:user) { create(:user) }

  def mock_mailer
    message_double = double('message double')
    allow(message_double).to receive(:deliver_later)
    allow(UserMailer).to receive(:register_complete)
                           .and_return(message_double)
    message_double
  end

  describe 'execute works ok! when' do
    context 'user hasnt finished its register process' do

      before do
        @params = {
          phone: "+52999#{Faker::Number.number(digits: 7)}",
          email: user.email,
          name: Faker::Name.name,
          paternal_surname: Faker::Name.last_name,
          maternal_surname: Faker::Name.last_name
        }
      end

      subject do
        service.execute(user, **@params)
      end

      it do
        message_double = mock_mailer
        expect(subject).to be_instance_of(User)
        expect(subject.status).to eq User::COMPLETE
        expect(subject.accounts).not_to be_nil
        expect(subject.accounts.first).to be_an_instance_of Account
        expect(subject.accounts.first.balance).to eq 0.0
        expect(subject.accounts.first.status).to eq Account::ACTIVE
        expect(UserMailer).to have_received(:register_complete)
        expect(message_double).to have_received(:deliver_later)
      end
    end
  end

  describe 'fails when' do
    context 'user hasnt confirmed his email' do

      before do
        not_confirmed_user =  create(:user, activation_code: SecureRandom.hex)
        @params = {
          phone: "+52999#{Faker::Number.number(digits: 7)}",
          email: not_confirmed_user.email,
          name: Faker::Name.name,
          paternal_surname: Faker::Name.last_name,
          maternal_surname: Faker::Name.last_name
        }
      end

      subject do
        service.execute(user, **@params)
      end

      it do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid) do |error|
          expect(error.message).not_to be_nil
        end
      end
    end
  end
end
