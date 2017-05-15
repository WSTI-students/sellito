class CategoryPolicy < ApplicationPolicy
  def update?
    if @user&.is_admin?
      render :edit
    else
      flash[:notice] = 'You are not an admin!'
      redirect_to categories_path
    end
  end

  def edit?
    update?
  end
end
