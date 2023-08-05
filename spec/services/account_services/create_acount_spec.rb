require 'rails_helper'

describe 'AccountServices::CreateAccount', type: :service do
  let(:service) { AccountServices::CreateAccount.new }

  let!(:user) { create(:user, phone: '+529999552058') }

  describe 'execute works ok! when' do
    context 'user does not exist' do
      subject do
        service.execute(email: Faker::Internet.email,
                        password: 'h3LL0_w0rld!',
                        password_confirmation: 'h3LL0_w0rld!',
                        phone: "+52999#{Faker::Number.number(digits: 7)}")
      end

      it do
        expect(subject).to be_instance_of(User)
        expect(subject.accounts).not_to be_nil
        expect(subject.accounts.first).to be_an_instance_of Account
        expect(subject.accounts.first.balance).to eq 0.0
        expect(subject.accounts.first.status).to eq Account::INACTIVE
        expect(subject.user_credential).not_to be_nil
      end
    end
  end

  describe 'fails when' do
    context 'an user with that email exists' do
      subject do
        service.execute(email: user.email,
                        password: 'h3LL0_w0rld!',
                        password_confirmation: 'h3LL0_w0rld!',
                        phone: "+52999#{Faker::Number.number(digits: 7)}")
      end

      it do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid) do |error|
          expect(error.message).not_to be_nil
        end
      end
    end

    context 'password_confirmation is not equal to password' do
      subject do
        service.execute(email: Faker::Internet.email,
                        password: 'h3LL0_w0rld!',
                        password_confirmation: 'not_the_same',
                        phone: "+52999#{Faker::Number.number(digits: 7)}")
      end

      it do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid) do |error|
          expect(error.message).not_to be_nil
        end
      end
    end

    context 'phone is invalid' do
      let(:bad_phone) { Faker::Number.number(digits: 6).to_s }
      subject do
        service.execute(email: Faker::Internet.email,
                        password: 'h3LL0_w0rld!',
                        password_confirmation: 'h3LL0_w0rld!',
                        phone: bad_phone)
      end

      it do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid) do |error|
          expect(error.message).not_to be_nil
        end
      end
    end
  end
end
