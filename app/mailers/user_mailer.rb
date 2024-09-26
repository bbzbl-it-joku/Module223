class UserMailer < ApplicationMailer
  def confirmation_instructions(user)
    @user = user
    @confirmation_url = confirm_email_url(confirmation_token: @user.confirmation_token)

    # mail(to: @user.email, subject: "Confirm your email")

    Rails.logger.debug("Mail sent to: #{@user.unconfirmed_email}")
    Rails.logger.debug("Subject: Confirm your new email")
    Rails.logger.debug("Body: #{@confirmation_url}")
  end

  def email_change(user)
    @user = user
    @confirmation_url = confirm_email_url(confirmation_token: @user.confirmation_token)

    # mail(to: @user.unconfirmed_email, subject: "Confirm your new email")

    Rails.logger.debug("Mail sent to: #{@user.unconfirmed_email}")
    Rails.logger.debug("Subject: Confirm your new email")
    Rails.logger.debug("Body: #{@confirmation_url}")
  end
end
