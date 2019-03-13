class Services::NotifySubscribers
  def initialize(question)
    @question = question
  end

  def notify
    subscribers.each do |user|
      NotifySubscriberMailer.send_mail(user.email, @question.title).deliver_later
    end
  end

  private

  def subscribers
    User.where(id: @question.subscribed.pluck(:user_id))
  end
end
