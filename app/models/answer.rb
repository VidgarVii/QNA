class Answer < ApplicationRecord
  belongs_to :question, counter_cache: true
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'

  validates :body, presence: true
end
