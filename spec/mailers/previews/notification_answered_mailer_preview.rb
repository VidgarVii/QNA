# Preview all emails at http://localhost:3000/rails/mailers/notification_answered_mailer
class NotificationAnsweredMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/notification_answered_mailer/notify
  def notify
    NotificationAnsweredMailer.notify
  end

end
