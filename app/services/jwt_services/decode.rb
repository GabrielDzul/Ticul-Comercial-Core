module JWTServices
  class Decode
    SECRET_KEY = Figaro.env.jwt_key
    def execute(token)
      decoded_token = JWT.decode(token, SECRET_KEY, true, { algorithm: 'HS256' })[0]
      HashWithIndifferentAccess.new decoded_token
    end
  end
end