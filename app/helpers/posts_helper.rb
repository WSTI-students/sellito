module PostsHelper
  def post_owner_or_admin(post)
    current_user && (post.user_id == current_user.id || current_user.is_admin?)
  end
end
