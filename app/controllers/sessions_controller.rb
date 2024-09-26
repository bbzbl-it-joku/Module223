class SessionsController < ApplicationController
  before_action :require_login, only: :destroy

  def new
    @user = User.new
  end

  def create
    user = User.authenticate_by(email: params[:email], password: params[:password])
    if user
      session[:user_id] = user.id
      redirect_to root_path, notice: "Logged in successfully"
    else
      render :new, alert: "Invalid email or password", status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out successfully"
  end
end
