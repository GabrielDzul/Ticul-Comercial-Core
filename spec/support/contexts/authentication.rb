require 'json'

RSpec.shared_context 'authentication', shared_context: :metadata do
  def create_user_with_token(user_attrs: {})
    user = build(:incomplete_user, **user_attrs)
    user.build_user_credential( password: 'p4ssW0rd!')
    user.save!

    user
  end

  def create_complete_user_with_token(user_attrs: {})
    user = build(
      :complete_user_with_credential,
      **user_attrs
    )
    user.save!

    user
  end

  def delete_authenticated(path, params: {}, headers: {}, user: authenticate_user)
    delete path,
           params: params.to_json,
           headers: create_headers(headers, user)
    response
  end

  def put_authenticated(path, params: {}, headers: {}, user: authenticate_user)
    put path,
        params: params.to_json,
        headers: create_headers(headers, user)
    response
  end

  def post_authenticated(path, params: {}, headers: {}, user: authenticate_user)
    post path,
         params: params.to_json,
         headers: create_headers(headers, user)
    response
  end

  def get_authenticated(path, params: {}, headers: {}, user: authenticate_user)
    get path,
        params: params.to_json,
        headers: create_headers(headers, user)
    response
  end

  private

  def create_headers(headers, user)
    {
      'content-type': 'application/json',
      'Authorization': 'Token ' + JWTServices::Encode.new.execute(user_id: user.id),
    }.merge(headers)
  end
end
