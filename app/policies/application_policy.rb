class ApplicationPolicy
  attr_reader :user, :record

  def initialize(current_user, record)
    @current_user = current_user
    @record = record
  end

  def index?
    false
  end

  def show?
    true
    #scope.where(:id => record.id).exists?
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  #disable scopes as acts_as_tenant is used

  #def scope
  #  Pundit.policy_scope!(user, record.class)
  #end

  #class Scope
  #  attr_reader :user, :scope

  #  def initialize(user, scope)
  #    @current_user = user
  #    @scope = scope
  #  end

  #  def resolve
  #    scope
  #  end
  #end
end
