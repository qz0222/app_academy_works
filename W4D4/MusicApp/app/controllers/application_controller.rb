class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  helper_method :current_user
  helper_method :logged_in?
  helper_method :log_in_user!
  helper_method :bounce

  def current_user
    user = User.find_by(session_token:session[:session_token])
    if user
      return user
    end
    nil
  end

  def logged_in?
    return true if current_user
    false
  end

  def log_in_user!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
  end

  def bounce
    unless logged_in?
      redirect_to new_session_url
    end
  end
end
