class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'

  validates :title, :body, presence: true

  # TODO
  # Излишние запросы. Можно обойтись partition

  def correct_answer
    answers.where(id: best_answer)
  end

  def not_rated_answers
    answers.where.not(id: best_answer)
  end
end
