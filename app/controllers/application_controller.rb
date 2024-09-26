class ApplicationController < ActionController::Base
  include Pundit::Authorization
  before_action :set_paper_trail_whodunnit
  helper_method :current_user, :logged_in?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def set_user
    @user = current_user
  end

  def require_login
    redirect_to login_path, alert: "You must be logged in to access this page." unless current_user
  end

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

  def set_paper_trail_whodunnit
    PaperTrail.request.whodunnit = current_user&.id
  end
end
