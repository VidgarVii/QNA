class Answer < ApplicationRecord
  include Fileable
  include Linkable
  include Rateable
  include Commentable

  belongs_to :question, counter_cache: true, touch: true
  belongs_to :author,   class_name: 'User', foreign_key: 'user_id'

  validates  :body, presence: true

  after_create :send_notification

  def make_the_best
    transaction do
      question.answers.update_all(best: false)
      update!(best: true)
      question.honor&.grand(author)
    end
  end

  private

  def send_notification
    NotificationAnsweredJob.perform_later(self.question.author)
  end
end
