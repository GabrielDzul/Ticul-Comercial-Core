class UserRepository < BaseRepository

  def update_credentials!(id:, **params)
    user = @db_client.find_by!(id: id)
    user_credential = user.user_credential || user.build_user_credential
    user_credential.update!(**params)
    user
  end
end