module App
  class UsersController < BaseController
    skip_before_action :authenticate_request, only: [:create]

    def create
      data = validate_request
      user = SignUpServices::SignUpPerson.new.execute(**data)
      @token = JWTServices::Encode.new.execute(user.id)

      #TODO: Create a token struct
      render json: { token: @token, type: 'jwt' }
    end
  end
end