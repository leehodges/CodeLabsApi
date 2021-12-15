# frozen_string_literal: true

require 'twilio-ruby'
module Communications
  # Communicates with our configured text messaging platform
  module Texts
    def self.deliver(to, message)
      # Fire off the worker
      TwilioWorker.perform_async(to, message)
    end
  end
end
