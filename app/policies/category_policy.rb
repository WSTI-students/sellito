class CategoryPolicy < ApplicationPolicy
  def update?
    :update if @user&.is_admin?
  end

  alias_method :edit?, :update?

  def destroy?
    :destroy if @user&.is_admin?
  end
end
