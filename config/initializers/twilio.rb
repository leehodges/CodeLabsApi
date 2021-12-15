Twilio.configure do |config|
  config.account_sid = Rails.application.credentials.twilio[:account_sid]
  config.auth_token = Rails.application.credentials.twilio[:auth_token]
  # raise "Environment variable TWILIO_ACCOUNT_SID not set" unless ENV['TWILIO_ACCOUNT_SID']
  # raise "Environment variable TWILIO_AUTH_TOKEN not set" unless ENV['TWILIO_AUTH_TOKEN']
end
