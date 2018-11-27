class UserPolicy < ApplicationPolicy
  def update?
    executive?
  end

  def destroy?
    executive?
  end

  def ban?
    admin? && user != record
  end

  def unban?
    ban?
  end
end
