class UserMailer < ApplicationMailer
  def welcome(user_id)
    user = UserRepository.instance.find_by!(id: user_id)

    @name = user.name
    @confirmation_url = activate_app_users_url(
      activation_code: user.activation_code
    )

    mail(
      to: user.email,
      subject: I18n.t('mailer.welcome.subject')
    )
  end

  def register_complete(user_id)
    user = UserRepository.instance.find_by!(id: user_id)

    @name = user.name

    mail(
      to: user.email,
      subject: I18n.t('mailer.register_complete.subject')
    )
  end

end
