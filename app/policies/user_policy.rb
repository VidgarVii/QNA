class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def finish_sign_up?
    # TODO dont work
    user && !user.email_verified?
  end
end
