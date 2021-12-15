# frozen_string_literal: true

# Defines the JSON blueprint for the User model
class UserBlueprint < Blueprinter::Base
  identifier :id
  fields :first_name, :last_name, :name, :email

  view :login do
    association :token, blueprint: TokenBlueprint do |user, _options|
      user.tokens.last
    end
  end

  view :normal do
    fields :first_name, :last_name, :name, :email, :phone
  end

end

