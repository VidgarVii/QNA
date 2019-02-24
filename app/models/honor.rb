class Honor < ApplicationRecord

  has_one_attached        :image
  has_and_belongs_to_many :users

  belongs_to :question

  validates :name, presence: true

  validates :image, attached: true,
            content_type: ['image/png', 'image/jpg', 'image/jpeg'],
            size: { less_than: 500.kilobytes }

  def grand(author)
    users.delete_all
    author.honors.push(self)
  end
end
