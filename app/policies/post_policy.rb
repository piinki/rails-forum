class PostPolicy < ApplicationPolicy
  def edit?
    record.user == user || user.admin? || user.moderator?
  end
end
