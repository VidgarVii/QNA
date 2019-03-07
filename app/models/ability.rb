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
    can :create,  [Question, Answer, Comment]
    can :update,  [Question, Answer], user_id: user.id

    cannot :rating_down, [Question, Answer], user_id: user.id
    cannot :rating_up, [Question, Answer], user_id: user.id
    can :rating_down, [Question, Answer]
    can :rating_up, [Question, Answer]

    can :finish_sign_up, User
    can :set_best,  Answer, question: { user_id: user.id }

    can :destroy, [Question, Answer], user_id: user.id
    cannot :destroy, [Question, Answer]

    #TODO Dont Work

    cannot :destroy, ActiveStorage::Attachment

    can :destroy, ActiveStorage::Attachment do |file|
      user.author_of?(file.record)
    end

    can :destroy, ActiveStorage::Attachment, record: { user_id: user.id }



  end
end
