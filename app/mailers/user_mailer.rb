class UserMailer < ApplicationMailer
  def welcome(user_id)
    user = UserRepository.instance.find_by!(id: user_id)

    @name = user.name

    mail(
      to: user.email,
      subject: I18n.t('mailer.welcome.subject')
    )
  end

end
