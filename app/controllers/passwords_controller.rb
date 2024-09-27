class PasswordsController < ApplicationController
  before_action :require_login

  def edit
  end

  def update
    if current_user.authenticate(password_params[:current_password])
      if current_user.update(password_params.except(:current_password))
        redirect_to current_user, notice: "Password updated successfully"
      else
        render :edit, status: :unprocessable_entity
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def password_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end
end
