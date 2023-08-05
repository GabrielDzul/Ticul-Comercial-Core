module App
  class UsersController < BaseController
    skip_before_action :authenticate_request, only: [:create, :activate]

    def create
      data = validate_request
      #user = SignUpServices::SignUpPerson.new.execute(**data)
      user = AuthenticationServices::SignUpByEmail.new.execute(**data)
      @token = JWTServices::Encode.new.execute(user.id)

      #TODO: Create a token struct
      render json: { token: @token, type: 'jwt' }
    end

    def activate
      data = validate_request
      UserServices::Activate.new.execute(activation_code: data[:activation_code])

      redirect_to welcome_misc_url
    end
  end
end