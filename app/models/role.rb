# frozen_string_literal: true

# Model that stores all of the available roles
class Role < ApplicationRecord
  validates_uniqueness_of :slug, presence: true

  scope :available_roles, -> { pluck(:slug) }

  def self.valid_role?(role)
    stringified_role = role.to_s.downcase.underscore
    stringified_role.in?(available_roles)
  end
end
