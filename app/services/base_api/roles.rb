# frozen_string_literal: true

module BaseApi
  # Container for methods related to handling roles on users
  module Roles
    # Handles determining if a user has a given role
    def role?(role)
      roles.any? { |r| r.slug.underscore.to_sym == role }
    end

    # Handles adding a role to a user
    def add_role(role)
      return ServiceContract.error('Role must be a symbol') if role.class.name.to_sym != :Symbol

      return ServiceContract.error("Role type '#{role}' is not available.") unless Role.valid_role?(role)

      target_role = Role.find_by_slug(role)
      roles << target_role unless roles.include?(target_role)
      ServiceContract.success(roles)
    end

    # Handles removing a role from a user
    def remove_role(role)
      return ServiceContract.error('Role must be a symbol') if role.class.name.to_sym != :Symbol

      return ServiceContract.error("Role type '#{role}' is not available.") unless Role.valid_role?(role)

      role = Role.find_by_slug(role)
      if user_roles.where(role: role).destroy_all
        ServiceContract.success(nil)
      else
        ServiceContract.error("Could not destroy #{role}")
      end
    end
  end
end