class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'

  validates :title, :body, presence: true

  def correct_answer
    answers.find(best_answer)
  end

  def not_rated_answers
    answers.where.not(id: best_answer)
  end
end
