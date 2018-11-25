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

  def moderator?
    user.moderator?
  end

  def admin?
    user.admin?
  end

  def executive?
    admin? && record != user
  end

  def perform?
    return false if user.banned?
    case user.role
    when "normal"
      executive?
    when "moderator"
      moderator?
    when "admin"
      true
    end
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
