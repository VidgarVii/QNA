class Question < ApplicationRecord
  has_one :honor, dependent: :destroy

  has_many :answers, dependent: :destroy
  has_many :links,   dependent: :destroy, as: :linkable

  belongs_to :author, class_name: 'User', foreign_key: 'user_id'

  has_many_attached :files

  accepts_nested_attributes_for :honor, reject_if: :all_blank
  accepts_nested_attributes_for :links, reject_if: :all_blank, allow_destroy: true

  validates :title, :body, presence: true
end
