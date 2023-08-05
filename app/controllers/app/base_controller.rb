module App
  class BaseController < ActionController::API
    include SchemaValidable
    include Authentication::AuthenticateByJWT
    include ActionController::HttpAuthentication::Token

    before_action :underscore_params!
    before_action :authenticate_request

    def underscore_params!
      params.deep_transform_keys! do |key|
        key.underscore
      end
    end
  end
end
