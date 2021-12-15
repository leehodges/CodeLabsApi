class TwilioWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'communication', retry: false
  require 'twilio-ruby'

  def perform(to, message)
    # Set up the required environment variables
    twilio_phone_number = Rails.application.credentials.twilio[:default_number]

    # Raise errors if environment variables not set
    raise "Environment variable TWILIO_DEFAULT_PHONE_NUMBER not set" unless twilio_phone_number

    # Send the text
    client = Twilio::REST::Client.new
    message = client.messages.create(from: twilio_phone_number.to_s, to: to.to_s, body: message)
    puts message.sid
  end
end
