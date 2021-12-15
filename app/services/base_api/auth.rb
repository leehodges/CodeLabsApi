# frozen_string_literal: true

module BaseApi
  # Handles user authentication (login, logout)
  module Auth
    def self.login(email, password, ip)
      # will return nil if no user found, will return false if the try authenticate doesn't work
      user = User.find_by(email: email).try(:authenticate, password)

      # If we couldn't find the user
      return ServiceContract.error('User not found') if user.nil?

      # If the password wasn't correct
      return ServiceContract.error('Incorrect password') unless user

      # generate the token on the user obj
      token = user.generate_token!(ip)
      ServiceContract.success({ user: user, token: token })
    end

    def self.logout(user, token)
      return ServiceContract.success(true) if user && token.update(revocation_date: DateTime.now)

      ServiceContract.error('Error logging user out')
    end

    def self.clear_other_tokens(user, token)
      if user
        Token.where(user_id: user.id).where.not(value: token).update(revocation_date: DateTime.now)
        return ServiceContract.success(true)
      else
        ServiceContract.error('Error Revoking Past Logins')
      end
    end

  end
end
