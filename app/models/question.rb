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

  scope :sort_by_update, -> { order(updated_at: :desc) }
  scope :sort_by_create, -> { order(:created_at) }
  scope :digest,         -> { where('created_at > ?', 1.day.ago) }

  def subscribe_to_author
    subscriptions.create(user: author)
  end
end
