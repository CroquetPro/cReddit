class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def login!(user)
    session[:session_token] = user.session_token
  end

  def logout!(user)
    user.reset_session_token!
    session[:session_token] = nil
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  private

  def require_current_user!
    if current_user.nil?
      flash[:notice] = ['Must be signed in to post/edit']
      redirect_to subs_url
    end
  end
end
