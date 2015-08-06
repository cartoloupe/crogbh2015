class ApplicationController < ActionController::Base
  after_filter :allow_iframe

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def must_be_logged_out
    render_404 unless CurrentUser.none?
  end

  def render_404
    respond_to do |format|
      format.html do
        render(
          file:   Rails.root.join('public', '404'),
          layout: false,
          status: :not_found
        )
      end
      format.xml { head :not_found }
      format.any { head :not_found }
    end
  end

  private
  def allow_iframe
    response.headers.delete "X-Frame-Options"
  end
end
