class CategoryPolicy < ApplicationPolicy
  def show?
    if user
      record.published? && perform?
    else
      record.published? && record.everyone_permission_view?
    end
  end

  class Scope < Scope
    def categories
      if user
        Category.published
      else
        Category.published.everyone_permission_view
      end
    end
  end
end
