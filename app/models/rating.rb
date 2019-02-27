class Rating < ApplicationRecord
  has_many   :votes, dependent: :destroy

  belongs_to :rateable, polymorphic: true
end
