class CategoriesController < ApplicationController
  #TODO: authorization with pundit gem

  before_action :fetch_category, only: %i[show edit update destroy]
  before_action :authorize_category, only: %i[edit update destroy]


  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.valid? ? create_category : handle_category_validation_error
  end

  def show; end

  def edit; end

  def update
    if @category.update(category_params)
      redirect_to @category
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    flash[:notice] = "Category #{@category.name} deleted"
    redirect_to categories_path
  end

  private

  def create_category
    @category.save
    flash[:notice] = 'Category created!'
    redirect_to category_path(@category)
  end

  def handle_category_validation_error
    flash[:errors] = @category.errors.full_messages
    redirect_back(fallback_location: root_path)
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def fetch_category
    @category = Category.find(params[:id])
  end

  def authorize_category
    authorize @category
  rescue Pundit::NotAuthorizedError
    authorization_failed
  end

  def authorization_failed
    flash[:notice] = 'You are not an admin!'
    redirect_to root_path
  end
end
