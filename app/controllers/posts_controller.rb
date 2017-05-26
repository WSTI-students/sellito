class PostsController < ApplicationController
  before_action :fetch_post, only: %i[show edit update destroy]
  before_action :authorize_post, only: %i[edit update destroy]

  def index
    @posts = Post.all.reverse
  end

  def user_posts
    @posts = current_user.posts
  end

  def new
    @post_form = PostForm.new
  end

  def create
    return unless params_have_valid_post_user_id
    @post_form = PostForm.new(post_form_params)
    @post_form.valid? ? create_post : handle_post_validation_failed
  end

  def show; end

  def edit
    @post_form = PostForm.new(@post)
  end

  def update
    @post_form = PostForm.new(post_form_params)
    UpdatePost.new(form_data: @post_form, post: @post).call
    redirect_to @post
  end

  def destroy
    @post.destroy
    flash[:notice] = "Post #{@post.title} deleted"
    redirect_to posts_path
  end

  private

  def create_post
    post = Post.create(
      title: @post_form.title,
      description: @post_form.description,
      expiration_date: @post_form.expiration_date,
      user_id: @post_form.user_id
    )
    AssignCategoryToPost.new(category_id: @post_form.category_id, post: post).call
    flash[:notice] = 'Post created!'
    redirect_to post
  end

  def params_have_valid_post_user_id
    post_form_params[:user_id] == current_user.id.to_s
  end

  def handle_post_validation_failed
    flash[:errors] = @post_form.errors.full_messages
    redirect_back(fallback_location: root_path)
  end

  def post_form_params
    params.require(:post_form).permit(:title, :description, :expiration_date, :category_id, :user_id)
  end

  def fetch_post
    @post = Post.find(params[:id])
  end

  def authorize_post
    authorize @post
  end
end
