module JWTServices
  class Encode
    SECRET_KEY = Figaro.env.jwt_key
    def execute(payload, exp = 7.days.from_now)
      exp_payload = { data: payload, exp: exp.to_i}
      JWT.encode(exp_payload, SECRET_KEY,'HS256')
    end
  end
end