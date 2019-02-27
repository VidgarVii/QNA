module Rateable
  extend ActiveSupport::Concern

  included do
    has_one :rating, dependent: :destroy, as: :rateable

    after_create :create_rating
  end

  def rate
    rating.score
  end

  def rate_up(user)
    return false if user.author_of?(self) || !user.has_right_up_rate?(rating)

    transaction do
      rating.update!(score: rating.score.next)
      vote(user).state_up
    end
  end

  def rate_down(user)
    return false if user.author_of?(self) || !user.has_right_down_rate?(rating)

    transaction do
      rating.update!(score: rating.score.pred)
      vote(user).state_down
    end
  end

  private

  def vote(user)
    @vote ||= Vote.find_by(rating: rating, user: user)
  end

  def create_rating
    create_rating!
  end
end
