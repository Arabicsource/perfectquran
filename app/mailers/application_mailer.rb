# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'quran.is.perfect@gmail.com'
  layout 'mailer'

  def contact
    @contact = params[:contact]
    mail(to: 'quran.is.perfect@gmail.com',
         from: @contact.email,
         subject: "Message from #{@contact.name}")
  end
end
