class Answer < ApplicationRecord
  has_many   :links, dependent: :destroy, as: :linkable

  belongs_to :question, counter_cache: true
  belongs_to :author,   class_name: 'User', foreign_key: 'user_id'

  has_many_attached :files

  accepts_nested_attributes_for :links, reject_if: :all_blank, allow_destroy: true


  validates :body, presence: true

  def make_the_best
    transaction do
      question.answers.update_all(best: false)
      update!(best: true)
      question.honor&.grand(author)
    end
  end
end
