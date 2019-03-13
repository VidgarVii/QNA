class Question < ApplicationRecord
  include Fileable
  include Linkable
  include Rateable
  include Commentable

  has_one :honor,     dependent: :destroy

  has_many :answers,       dependent: :destroy
  has_many :subscribed,    class_name: 'Subscription', dependent: :destroy

  belongs_to :author, class_name: 'User', foreign_key: 'user_id'

  accepts_nested_attributes_for :honor, reject_if: :all_blank

  validates :title, :body, presence: true

  after_create :subscribe_to_author
  after_update :notify_subscribers

  scope :sort_by_update, -> { order(updated_at: :desc) }

  private

  def notify_subscribers

  end

  def subscribe_to_author
    subscribed.create(user: author)
  end
end
