class AdminsController < ApplicationController
  include Pundit::Authorization

  before_action :logged_in?
  after_action :verify_authorized

  def index
    authorize :admin
  end

  def user_management
    authorize :admin
    @users = User.page(params[:page]).per(25)
  end

  def activity
    authorize :admin
    @versions = PaperTrail::Version.order(created_at: :desc).includes(:item).page(params[:page]).per(50)
  end

  private

  def pundit_user
    current_user
  end
end
