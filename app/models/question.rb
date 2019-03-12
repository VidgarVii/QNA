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

  after_create :calculate_reputation

  scope :sort_by_update, -> { order(:updated_at) }

  private

  def calculate_reputation
    ReputationJob.perform_later(self)
  end
end
