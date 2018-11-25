class PostPolicy < ApplicationPolicy
  def create?
    !user.banned?
  end

  def edit?
    perform?
  end

  def destroy?
    perform?
  end

  def restore?
    admin? && moderator?
  end

  def moderator?
    user.moderator? && record.topic.moderators.include?(user)
  end

  def executive?
    record.user == user
  end
end
