class NotifySubscribersJob < ApplicationJob
  queue_as :default

  def perform(question)
    service = Services::NotifySubscribers.new(question)
    service.notify
  end
end
