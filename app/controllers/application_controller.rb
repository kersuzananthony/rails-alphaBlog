class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Tell users the following methods are helpers
  helper_method :current_user, :logged_in?

  # Return an user object if user_id is stored in session.
  # Return @current_user if it already exists
  # Ask database for the correct user if @current_user does not exist yet and store it
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    # !! convert anything to bool
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:danger] = 'You must be logged in to perform that action'
      redirect_to root_path
    end
  end

  def require_anonymous
    if logged_in?
      flash[:danger] = 'You are already logged in!'
      redirect_to root_path
    end
  end

  def require_admin
    if logged_in? && !current_user.admin?
      flash[:danger] = 'Only admin users can perform that action'
      redirect_to root_path
    end
  end
end
