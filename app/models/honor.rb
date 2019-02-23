class Honor < ApplicationRecord
  belongs_to :question

  has_one_attached :image

  validates :name, presence: true

  validates :image, attached: true,
            content_type: ['image/png', 'image/jpg', 'image/jpeg'],
            size: { less_than: 500.kilobytes }
end
