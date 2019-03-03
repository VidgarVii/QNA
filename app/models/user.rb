class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:github]

  has_many :questions
  has_many :comments,          dependent: :destroy
  has_many :answers
  has_many :honors
  has_many :votes,             dependent: :destroy
  has_many :autherizetions,    dependent: :destroy

  def self.find_for_oauth(auth)
    autherization = Autherizetion.where(provider: auth.provider, uid: auth.uid.to_s).first
    autherization.user if autherization
  end

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
