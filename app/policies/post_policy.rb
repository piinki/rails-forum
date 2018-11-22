class PostPolicy < ApplicationPolicy
  def create?
    perform?
  end

  def edit?
    record.user == user || manager?
  end
end
