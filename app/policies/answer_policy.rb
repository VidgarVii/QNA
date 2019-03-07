class AnswerPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    user.admin? || user
  end

  def update?
    user.admin? || user.author_of?(record)
  end

  def destroy?
    user.admin? || user.author_of?(record)
  end

  def set_best?
    user.admin? || user.author_of?(record.question)
  end
end
