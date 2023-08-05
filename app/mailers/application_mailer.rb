class ApplicationMailer < ActionMailer::Base
  default template_path: -> { "mailers/#{self.class.name.underscore}" }

  SENDER_EMAIL = Figaro.env.smtp_username
  SENDER = "Enso  <#{SENDER_EMAIL}>".freeze

  default from: SENDER
  layout "mailer"
end
