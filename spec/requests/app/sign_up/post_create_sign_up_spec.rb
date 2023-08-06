require 'rails_helper'
require 'support/contexts/authentication'
require 'support/shared_examples/success_api_response'

RSpec.describe "POST app/sign_up", type: :request do
  include_context 'authentication'

  describe "Creates a user" do
    let(:authenticate_user) { create_user_with_token }

    #Given
    before do
      @params = {
        phone: "+52999#{Faker::Number.number(digits: 7)}",
        email: authenticate_user.email,
        name: Faker::Name.name,
        paternal_surname: Faker::Name.last_name,
        maternal_surname: Faker::Name.last_name
      }
    end

    # When
    subject do
      post_authenticated app_sign_up_path, params: @params
      response
    end

    it_behaves_like 'success api response', 'app/users/user'
  end
end
