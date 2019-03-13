# Preview all emails at http://localhost:3000/rails/mailers/notify_subscriber
class NotifySubscriberPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/notify_subscriber/send_mail
  def send_mail
    NotifySubscriberMailer.send_mail('mail@mail.ru', 'Tittle')
  end

end
