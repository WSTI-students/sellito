module ApplicationHelper
  def sign_up_user_link
    link_to 'Sign up', new_user_registration_path
  end

  def login_or_logout_link
    current_user ? logout_user_link : login_user_link
  end

  def login_user_link
    login_tag = "<li>#{link_to 'Log in', new_user_session_path}</li>"
    login_tag.html_safe
  end

  def logout_user_link
    link_to 'Logout', destroy_user_session_path, method: :delete
  end

  def current_user_is_admin
    current_user&.is_admin?
  end

  def show_categories_for_admin
    categories_link_tag = "<li>#{link_to 'Categories', categories_path}</li>"
    categories_link_tag.html_safe if current_user_is_admin
  end
end
