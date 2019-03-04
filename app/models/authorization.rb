class Authorization < ApplicationRecord
  belongs_to :user

  validates :uid, :provider, presence: true
end
