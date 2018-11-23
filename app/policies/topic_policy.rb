class TopicPolicy < ApplicationPolicy
  def new?
    perform?
  end

  def create?
    new?
  end

  def edit?
    record.creator == user && perform?
  end

  def destroy?
    edit?
  end

  def toggle_lock?
    return false if user.banned?
    case user.role
    when "normal"
      user == record.creator
    when "moderator"
      record.category.moderators.include?(user) && !record.creator.admin?
    when "admin"
      true
    end
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
