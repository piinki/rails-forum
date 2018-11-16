class UserPolicy < ApplicationPolicy
  def update?
    executive?
  end

  def destroy?
    executive?
  end
end
