# frozen_string_literal: true

class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user

    if user
      user.admin? ? admin_abilities : user_abilities
    else
      quest_abilities
    end
  end

  def quest_abilities
    can :read, :all
  end

  def admin_abilities
    can :manage, :all
  end

  def user_abilities
    quest_abilities

    can :create,   [Question, Answer, Comment, Subscription]
    can :set_best,       Answer,                    question: { user_id: user.id }
    can :destroy,        ActiveStorage::Attachment, record: { user_id: user.id }
    can :finish_sign_up, User,                      id: user.id

    can %i[rating_down rating_up],[Question, Answer]
    can %i[update destroy],       [Question, Answer, Subscription], user_id: user.id

    cannot %i[rating_down rating_up],      [Question, Answer], user_id: user.id
  end
end
