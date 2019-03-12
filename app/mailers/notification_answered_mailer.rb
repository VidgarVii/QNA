class NotificationAnsweredMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification_answered_mailer.notify.subject
  #
  def notify(user)
    @greeting = "Hello. Answer you"

    mail to: user.email,
         subject: 'Answer you'
  end
end
