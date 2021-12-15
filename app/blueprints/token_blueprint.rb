# frozen_string_literal: true

# Defines the JSON blueprint for the Token model
class TokenBlueprint < Blueprinter::Base
  identifier :id
  fields :expiry, :ip, :revocation_date, :value, :created_at, :updated_at, :user_id
end
