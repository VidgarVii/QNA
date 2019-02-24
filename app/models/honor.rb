class Honor < ApplicationRecord

  has_one_attached :image

  belongs_to :question
  belongs_to :user, optional: true

  validates :name, presence: true

  validates :image, attached: true,
            content_type: ['image/png', 'image/jpg', 'image/jpeg'],
            size: { less_than: 500.kilobytes }

  def grand(author)
    self.user = author
    save!
  end
end
