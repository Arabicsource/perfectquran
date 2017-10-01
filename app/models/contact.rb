# frozen_string_literal: true

# :nodoc:
class Contact < MailForm::Base
  attribute :name, validate: true
  attribute :email, validate: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i

  attribute :message, validate: true
  attribute :username, captcha: true

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      subject: 'PerfectQuran Contact',
      to: 'quran.is.perfect@gmail.com',
      from: %("#{name}" <#{email}>)
    }
  end
end
