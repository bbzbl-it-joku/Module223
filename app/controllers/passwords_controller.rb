class PasswordsController < ApplicationController
  before_action :require_login

  def edit
  end

  def update
    if current_user.authenticate(params[:current_password])
      if current_user.update(password_params)
        redirect_to current_user, notice: "Password changed successfully."
      else
        render :edit, status: :unprocessable_entity
      end
    else
      flash.now[:alert] = "Current password is incorrect."
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
