class UsersController < ApplicationController
  before_action :require_login, except: [ :new, :create ]
  before_action :set_user, only: [ :show, :edit, :update, :destroy ]
  before_action :authorize_user, only: [ :show, :edit, :update ]

  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_create_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Account created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def confirm_email
    user = User.find_by(confirmation_token: params[:confirmation_token])

    if user
      user.confirm!
      session[:user_id] = user.id
      redirect_to root_path, notice: "Your email has been confirmed."
    else
      redirect_to root_path, alert: "Invalid confirmation token."
    end
  end

  def update
    if @user.update(user_update_params)
      if user_update_params[:email] && @user.email != user_update_params[:email]
        @user.update(unconfirmed_email: user_update_params[:email], email: @user.email, confirmation_token: SecureRandom.urlsafe_base64, confirmation_sent_at: Time.current, confirmed_at: nil)
        @user.generate_confirmation_token

        UserMailer.email_change(@user).deliver_now

        redirect_to @user, notice: "Profile updated. Please confirm your new email."
      else
        redirect_to @user, notice: "Profile updated successfully."
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    if @user == current_user
      session[:user_id] = nil
    end
    redirect_to root_path, notice: "Account deleted."
  end

  def resend_confirmation
    current_user.generate_confirmation_token
    current_user.send_confirmation_instructions
    redirect_to root_path, notice: "Confirmation email has been resent."
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])

    unless @user
      redirect_to error_path, alert: "User not found."
    end
  end

  def authorize_user
    redirect_to error_path, alert: "Not authorized." unless @user == current_user or current_user.role == "ADMIN"
  end

  def user_create_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation).merge(confirmation_token: SecureRandom.urlsafe_base64).merge(confirmation_sent_at: Time.current)
  end

  def user_update_params
    params.require(:user).permit(:username, :email)
  end
end
