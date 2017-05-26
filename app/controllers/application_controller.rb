class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  def current_user
    if session['warden.user.user.key']
      super
    else
      @current_user ||= NullObjects::User.new
    end
  end
end
