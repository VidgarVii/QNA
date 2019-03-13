class NotifySubscriberMailer < ApplicationMailer

  def send_mail(email, title)
    @title = title

    mail to: email,
         subject: "News for question"
  end
end
