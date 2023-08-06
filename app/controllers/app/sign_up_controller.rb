module App
  class SignUpController < BaseController
    def create
      data = validate_request
      user = SignUpServices::SignUpPerson.new.execute(@current_user, **data)

      render json: user, serializer: App::UserSerializer
    end
  end
end