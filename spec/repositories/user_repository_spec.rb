require 'rails_helper'

describe UserRepository, type: :repository do
  let(:user) { create(:user) }

  describe 'update_credentials!' do
    context 'works ok when' do
      context 'credentials exist' do
        let(:valid_params) do
          {
            password: 'h3LL0_w0rld!',
            password_confirmation: 'h3LL0_w0rld!',
          }
        end

        let(:user) { create(:user, user_credential: create(:user_credential)) }

        subject { UserRepository.instance.update_credentials!(id: user.id, **valid_params.to_h.symbolize_keys) }

        it { expect(subject).to be_an_instance_of User }
      end

      context 'credentials do not exist' do
        let(:valid_params) do
          {
            password: 'h3LL0_w0rld!',
            password_confirmation: 'h3LL0_w0rld!',
          }
        end

        let(:user) { create(:user) }

        subject { UserRepository.instance.update_credentials!(id: user.id, **valid_params.to_h.symbolize_keys) }

        it { expect(subject).to be_an_instance_of User }
      end
    end

    describe 'fails ok!' do
      context 'if invalid params' do
        let(:invalid_params) do
          {
            password: 'h3LL0_w0rld!',
            password_confirmation: 'h3LL0_',
          }
        end

        let(:user) { create(:user) }

        subject { UserRepository.instance.update_credentials!(id: user.id, **invalid_params.to_h.symbolize_keys) }

        it { expect { subject }.to raise_error(ActiveRecord::RecordInvalid) }
      end

      context 'by a unknown param' do
        let(:user) { create(:user) }

        it do
          expect do
            UserRepository.instance.update_credentials!(
              id: user.id,
              data: 'dummy'
            )
          end.to raise_error(ActiveRecord::UnknownAttributeError)
        end
      end

      context 'if not found' do
        let(:valid_params) do
          {
            password: 'h3LL0_w0rld!',
            password_confirmation: 'h3LL0_w0rld!',
          }
        end

        subject { UserRepository.instance.update_credentials!(id: SecureRandom.uuid, **valid_params.to_h.symbolize_keys) }

        it { expect { subject }.to raise_error(ActiveRecord::RecordNotFound) }
      end
    end
  end
end
