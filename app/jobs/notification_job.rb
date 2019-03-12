class NotificationJob < ApplicationJob
  queue_as :default

  def perform(user)
    NotificationMailer.notify(user)
  end
end
