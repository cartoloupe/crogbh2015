class ApplicationController < ActionController::Base
  after_filter :allow_iframe

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    return nil unless session[:user_id].present?
    User.find_by id: session[:user_id]
  end

  private
  def allow_iframe
    response.headers.delete "X-Frame-Options"
  end
end
