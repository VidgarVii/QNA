class NotificationAnsweredJob < ApplicationJob
  queue_as :default

  def perform(user)
    NotificationAnsweredMailer.notify(user)
  end
end
