class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: %i[github vkontakte instagram]

  has_many :questions
  has_many :comments,          dependent: :destroy
  has_many :answers
  has_many :honors
  has_many :votes,             dependent: :destroy
  has_many :authorizations,    dependent: :destroy

  def self.find_for_oauth(auth)
    Services::FindForOauth.new(auth).call
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

  def create_authorization(auth)
    authorizations.create(provider: auth.provider, uid: auth.uid)
  end

  private

  def set_state(rating)
    votes.find_or_create_by(rating: rating).state
  end
end
