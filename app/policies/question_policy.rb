class QuestionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    user.admin? || user
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
end
