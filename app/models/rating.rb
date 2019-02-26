class Rating < ApplicationRecord
  belongs_to :rateable, polymorphic: true
end
