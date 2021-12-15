# frozen_string_literal: true

# Invite User to Register
class UserNotifierMailer < ApplicationMailer
  default from: Rails.application.credentials.sendgrid[:default_email]

  # send signup email to user
  def send_signup_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to blah blah blah #{@user.first_name}")
  end
end
