class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def create?
    new?
  end

  def update?
    edit?
  end

  def manager?
    user.admin? || user.moderator?
  end

  def admin?
    user.admin?
  end

  def executive?
    admin? && record != user
  end

  def perform?
    !user.banned? || manager?
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end
