module Authentication
  module AuthenticateByJWT
    def authenticate_request
      token, _options = token_and_options(request)
      raise Error::Unauthorized if @current_user.blank?

      decoded = JWTServices::Decode.new.execute(token)
      @current_user = UserRepository.instance.find_by!(id: decoded[:user_id])
      raise Error::Unauthorized if @current_user.blank?
    end
  end
end