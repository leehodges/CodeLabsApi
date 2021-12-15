class Api::V1::ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate

  def authenticate
    authenticate_token || render_unauthorized
  end

  def authenticate_token
    @ip = request.remote_ip || 'unknown'
    authenticate_with_http_token do |token, _options|
      @token = Token.find_by(value: token)
      if @token.nil?
        render_unauthorized
      else
        if @token.expiry.after?(DateTime.now) && @token.revocation_date.blank?
          @current_user = @token.user
          @current_user
        else
          render_unauthorized
        end
      end
    end
  end

  def render_unauthorized
    logger.debug "*** UNAUTHORIZED REQUEST: '#{request.env['HTTP_AUTHORIZATION']}' ***"
    headers['WWW-Authenticate'] = 'Token realm="Application"'
    render json: { error: 'Bad credentials' }, status: 401 and return
  end

  def ensure_required_params(required_params, passed_in_params)
    required_params = required_params.map(&:to_sym)
    passed_in_params = passed_in_params.keys.map(&:to_sym)

    remainder = required_params - passed_in_params

    count = remainder.size
    errors = remainder

    render json: { message: "Missing required parameters: #{errors.to_sentence}" }, status: :bad_request and return unless count.zero?
  end

  def render_error(errors:, status: :internal_server_error)
    render json: {
      success: false,
      errors: errors
    }, status: status
  end

  def render_success(payload:, status: :ok)
    render json: {
      success: true,
      payload: payload
    }, status: status
  end
end
