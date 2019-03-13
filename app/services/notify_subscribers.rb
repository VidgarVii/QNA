class Services::NotifySubscribers
  def initialize(question)
    @question = question
  end

  def notify
    @question.subscribers.each do |user|
      NotifySubscriberMailer.send_mail(user.email, @question.title).deliver_later
    end
  end
end
