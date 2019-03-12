# Preview all emails at http://localhost:3000/rails/mailers/notification_answered_mailer
class NotificationMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/notification_answered_mailer/notify
  def notify
    NotificationMailer.notify
  end

end
