# frozen_string_literal: true

require 'digest/sha1'
module BaseApi
  # Generates a random access token
  module AccessToken
    def self.generate(model)
      Digest::SHA1.hexdigest("#{model_info(model)}-[racer_api-#{model.id.to_s(36)}]-[#{random_day}]")
    end

    def self.model_info(model)
      "#{model}-#{model.id}-#{model.created_at}"
    end

    def self.random_day
      rand(-200..200).days.ago
    end
  end
end
