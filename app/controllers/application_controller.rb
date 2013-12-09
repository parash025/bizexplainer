class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :project_link

  private

  def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def project_link
    if current_user.user_type == 'user'
      projects_path
    else
      admin_path
    end
  end

end
