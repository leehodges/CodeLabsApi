ActionMailer::Base.smtp_settings = {
  domain: Rails.application.credentials.sendgrid[:domain],
  address: Rails.application.credentials.sendgrid[:server],
  port: 587,
  authentication: :plain,
  user_name: Rails.application.credentials.sendgrid[:username],
  password: Rails.application.credentials.sendgrid[:api],
  :enable_starttls_auto => true
}