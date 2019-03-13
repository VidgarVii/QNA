class Question < ApplicationRecord
  include Fileable
  include Linkable
  include Rateable
  include Commentable

  has_one :honor,     dependent: :destroy

  has_many :answers,       dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :subscribers,   through: :subscriptions, source: :user

  belongs_to :author, class_name: 'User', foreign_key: 'user_id'

  accepts_nested_attributes_for :honor, reject_if: :all_blank

  validates :title, :body, presence: true

  after_create :subscribe_to_author
  after_touch  :notify_subscribers

  scope :sort_by_update, -> { order(updated_at: :desc) }

  private

  def notify_subscribers
    NotifySubscribersJob.perform_later(self)
  end

  def subscribe_to_author
    subscriptions.create(user: author)
  end
end
