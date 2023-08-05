require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'welcome' do
    it 'renders the headers' do
      user = create(
        :complete_user,
      )

      mail = described_class.welcome(user.id)
      expect(mail.subject).to eq(I18n.t('mailer.welcome.subject'))
      expect(mail.to).to eq([user.email])
      expect(mail.from).to match([Figaro.env.smtp_username])
    end
  end
end
