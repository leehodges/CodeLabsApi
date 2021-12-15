class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate

  def authenticate
    authenticate_token || render_unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |token, options|
      @current_user = User.find_by(token: token)
      @current_user
    end
  end

  def render_unauthorized
    logger.debug "*** UNAUTHORIZED REQUEST: '#{request.env['HTTP_AUTHORIZATION']}' ***"
    self.headers['WWW-Authenticate'] = 'Token realm="Application"'
    render json: {error:"Bad credentials"}, status: 401
  end
end
