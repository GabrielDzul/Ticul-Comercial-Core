require 'rails_helper'
#require 'test_prof/recipes/rspec/let_it_be'

describe 'SignUpServices::SignUpPerson', type: :service do
  let(:service) { SignUpServices::SignUpPerson.new }

  let!(:user) { create(:user, phone: '+529999552058') }
  let!(:account) { create(:account, user: user) }

  def mock_mailer
    message_double = double('message double')
    allow(message_double).to receive(:deliver_later)
    allow(UserMailer).to receive(:welcome)
                           .and_return(message_double)
    message_double
  end

  describe 'execute works ok! when' do
    context 'user does not exist' do
      subject do
        service.execute(email: Faker::Internet.email,
                        password: 'h3LL0_w0rld!',
                        password_confirmation: 'h3LL0_w0rld!',
                        phone: "+52999#{Faker::Number.number(digits: 7)}"
        )
      end

      it do
        message_double = mock_mailer
        expect(subject).to be_instance_of(User)
        expect(subject.accounts).not_to be_nil
        expect(subject.accounts.first).to be_an_instance_of Account
        expect(subject.accounts.first.balance).to eq 0.0
        expect(subject.accounts.first.status).to eq Account::INACTIVE
        expect(UserMailer).to have_received(:welcome)
        expect(message_double).to have_received(:deliver_later)
      end
    end
  end
end
