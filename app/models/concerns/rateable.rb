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
    if user.author_of?(self)
      false
    else
      rating.update!(score: rating.score.next)
    end
  end

  def rate_down(user)
    if user.author_of?(self)
      false
    else
      rating.update!(score: rating.score.pred)
    end
  end

  private

  def create_rating
    create_rating!
  end
end
