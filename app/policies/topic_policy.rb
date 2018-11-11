class TopicPolicy < ApplicationPolicy
  def edit?
    record.creator == user || user.admin? || user.moderator?
  end

  def destroy?
    edit?
  end
end
