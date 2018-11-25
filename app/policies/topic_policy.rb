class TopicPolicy < ApplicationPolicy
  def new?
    !user.banned?
  end

  def create?
    new?
  end

  def edit?
    perform?
  end

  def destroy?
    perform?
  end

  def pin?
    admin? || moderator?
  end

  def executive?
    record.creator == user
  end

  def moderator?
    user.moderator? && record.moderators.include?(user)
  end

  def toggle_lock?
    perform?
  end

  class Scope < Scope
    def resolve
      if user
        Topic.by_category Category.published
      else
        Topic.by_category Category.everyone_permission_view.published
      end
    end
  end
end
