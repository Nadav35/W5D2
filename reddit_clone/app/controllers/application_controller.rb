class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :get_subs
  
  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end
  
  def get_subs
    subs = Sub.all
    subs
  end
  
  def logged_in?
    !!current_user
  end
  
  def require_logged_in
    redirect_to new_session_url unless logged_in?
  end
  
  def logout!
    current_user.reset_session_token!
    session[:session_token] = nil
  end
  
  def login!(user)
    @current_user = user
    session[:session_token] = @current_user.reset_session_token!
  end
end
