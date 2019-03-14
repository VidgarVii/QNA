class Answer < ApplicationRecord
  include Fileable
  include Linkable
  include Rateable
  include Commentable

  belongs_to :question, counter_cache: true
  belongs_to :author,   class_name: 'User', foreign_key: 'user_id'

  validates  :body, presence: true

  after_create :notify_subscribers

  def make_the_best
    transaction do
      question.answers.update_all(best: false)
      update!(best: true)
      question.honor&.grand(author)
    end
  end

  private

  def notify_subscribers
    NotifySubscribersJob.perform_later(self.question)
  end
end
