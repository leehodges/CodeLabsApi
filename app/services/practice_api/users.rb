# frozen_string_literal: true

module PracticeApi
  module Users
    def self.new_user(params)

      user = User.new(
        first_name: params[:first_name],
        last_name: params[:last_name],
        email: params[:email],
        password: params[:password],
        password_confirmation: params[:password_confirmation]
      )
      begin
        user.save!
      rescue ActiveRecord::RecordInvalid => exception
        return ServiceContract.error('Error saving user.') unless user.valid?
      end

      ServiceContract.success(user)
    end

    def self.destroy_user(user_id)
      user = User.find(user_id)
      return ServiceContract.error('Error deleting user') unless user.destroy

      ServiceContract.success(payload: user)
    end
  end
end
