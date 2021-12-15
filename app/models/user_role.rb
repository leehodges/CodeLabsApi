# frozen_string_literal: true

# Join model that connects users to roles
class UserRole < ApplicationRecord
  belongs_to :user
  belongs_to :role

  validates_uniqueness_of :user, scope: :role
end
