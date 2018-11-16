class CategoryManagerPolicy < ApplicationPolicy
  def destroy?
    admin?
  end
end
