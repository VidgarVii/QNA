class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :rating

  validates :state,
            presence: true,
            inclusion: { in: -1..1, message: "%{value} is not a valid size" }

  def state_up
    update!(state: state.next)
  end

  def state_down
    update!(state: state.pred)
  end
end
