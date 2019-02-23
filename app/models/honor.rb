class Honor < ApplicationRecord
  belongs_to :question

  has_one_attached :image

  validates :name, :image, presence: true
end
