# frozen_string_literal: true

module Api
  module V1
    # Handles endpoints related to users
    class UsersController < Api::V1::ApplicationController
      skip_before_action :authenticate, only: %i[login create]

      def login
        result = BaseApi::Auth.login(params[:email], params[:password], @ip)
        render_error(errors: 'User not authenticated', status: 401) and return unless result.success?

        payload = {
          user: UserBlueprint.render_as_hash(result.payload[:user], view: :login),
          token: TokenBlueprint.render_as_hash(result.payload[:token]),
          status: 200
        }
        render_success(payload: payload)
      end

      def logout
        result = BaseApi::Auth.logout(@current_user, @token)
        render_error(errors: 'There was a problem logging out', status: 401) and return unless result.success?

        render_success(payload: 'You have been logged out', status: 200)
      end

      def create
        result = BaseApi::Users.new_user(params)
        render_error(errors: 'There was a problem creating a new user', status: 400) and return unless result.success?
        payload = {
          user: UserBlueprint.render_as_hash(result.payload, view: :normal)
        }
        #  TODO: Invite user to accept invitation via registered email
        render_success(payload: payload, status: 201)
      end

      def me
        render_success(payload: UserBlueprint.render_as_hash(@current_user), status: 200)
      end

      def validate_invitation
        user = User.invite_token_is(params[:invitation_token]).invite_not_expired.first

        render_error(errors: { validated: false, status: 401 }) and return if user.nil?
        render_success(payload: { validated: true, status: 200 })
      end
    end
  end
end
