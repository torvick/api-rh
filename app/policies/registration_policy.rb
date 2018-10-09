class RegistrationPolicy < ApplicationPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @user = model
  end

  def index?
    @current_user.admin? || @current_user.employee?
  end

  def show?
    @current_user.admin? || @current_user.employee?
  end

  def create?
    @current_user.admin?
  end

  def update?
    @current_user.admin?
  end

  def destroy?
    @current_user.admin?
  end
end
