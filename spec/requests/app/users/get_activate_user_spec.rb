require 'rails_helper'
require 'support/shared_examples/success_api_response'

RSpec.describe "GET app/activate", type: :request do
  describe "Activates a user" do

    #Given
    let(:user){ create(:user, activation_code: SecureRandom.hex) }

    # When
    subject do
      get activate_app_users_path(activation_code: user.activation_code)
      response
    end

    it do
      expect(subject).to redirect_to(welcome_misc_path)
    end
  end
end
