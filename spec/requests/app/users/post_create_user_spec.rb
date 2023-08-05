require 'rails_helper'
require 'support/shared_examples/success_api_response'

RSpec.describe "POST app/users", type: :request do
  describe "Creates a user" do
    #Given
    params =  {
      email: Faker::Internet.email,
      password: 'h3LL0_w0rld!',
      passwordConfirmation: 'h3LL0_w0rld!'
    }

    # When
    subject do
      post app_users_path, params: params
      response
    end

    it_behaves_like 'success api response', 'app/sessions/token'
  end
end
