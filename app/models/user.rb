class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :questions
  has_many :comments, dependent: :destroy
  has_many :answers
  has_many :honors
  has_many :votes,    dependent: :destroy

  def author_of?(resource)
    resource.user_id == id
  end

  def has_right_up_rate?(rating)
    !set_state(rating).positive?
  end

  def has_right_down_rate?(rating)
    !set_state(rating).negative?
  end

  private

  def set_state(rating)
    votes.find_or_create_by(rating: rating).state
  end
end
