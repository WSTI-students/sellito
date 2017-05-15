class CategoryPolicy < ApplicationPolicy
  def update?
    :update if @user&.is_admin?
  end

  def edit?
    update?
  end
end
