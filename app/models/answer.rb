class Answer < ApplicationRecord
  belongs_to :question, counter_cache: true
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'

  has_many_attached :files

  validates :body, presence: true

  def make_the_best
    transaction do
      question.answers.update_all(best: false)
      update!(best: true)
    end
  end
end
